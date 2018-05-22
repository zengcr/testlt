# CORS
- 跨域资源共享 Cross-origin resource sharing

## 两种请求
- 简单请求：需同时满足以下两大条件
	1. 请求方法是以下三种方法之一：
		- HEAD
		- GET
		- POST
	2. HTTP的头信息不超出以下几种字段：
		- Accept
		- Accep-Language
		- Content-Language
		- Last-Event-ID
		- Content-Type:只限于三个值application/x-www-form-urlencoded、multipart/form-data、text/plain
- 非简单请求 