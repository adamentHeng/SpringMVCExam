# SpringMVCExam
SpringMVCExam

数据库配置文件位置：src/main/resources/config/jdbc.properties
启动服务器：mvn jetty:run
拦截器一般用来拦截http请求，尝试对静态页面拦截后产生了越来越多的问题，所以只实现了对http请求的拦截