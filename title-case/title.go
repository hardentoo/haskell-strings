package main

import (
  "fmt"
  "io/ioutil"
  "bytes"
)

func main() {
  body, _ := ioutil.ReadFile("input.txt")
  result := bytes.Title(body)
  fmt.Printf("%s", result)
}
