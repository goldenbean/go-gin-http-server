package main

import (
	"log"
	"net/http"
	"path/filepath"

	"github.com/gin-gonic/gin"
)

func main() {

	name := ""
	router := gin.Default()
	router.GET("/", func(c *gin.Context) {
		c.String(http.StatusOK, "Hello %s", name)
	})
	router.Static("/public", "./public")
	router.StaticFile("/favicon.ico", "./assets/favicon.ico")
	router.StaticFS("/files", http.Dir("./"))

	router.POST("/upload", func(c *gin.Context) {

		// Multipart form
		form, err := c.MultipartForm()
		if err != nil {
			c.String(http.StatusBadRequest, "get form err: %s", err.Error())
			return
		}
		files := form.File["files"]

		for _, file := range files {
			filename := filepath.Base(file.Filename)
			log.Printf("filename: %s", filename)
			if err := c.SaveUploadedFile(file, "./upload/"+filename); err != nil {
				log.Fatal("filename:", file, err)

				c.String(http.StatusBadRequest, "upload file err: %s", err.Error())
				return
			}
		}

		c.String(http.StatusOK, "Uploaded successfully %d files", len(files))
	})
	router.RunTLS(":8081", "./certs/server.pem", "./certs/server.key")
}
