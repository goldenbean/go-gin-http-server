package main

import (
    "github.com/gin-gonic/gin"
    "net/http"
)

func main()  {
    router := gin.Default()
	router.StaticFS("/files", http.Dir("./"))  // use the loaded source
    router.Run(":8080")
}