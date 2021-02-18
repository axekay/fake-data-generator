var formatOptions : Map[String,String] =Map[String,String]()
formatOptions = formatOptions + ("header" -> "true") + ("delimiter" -> "|") + ("inferSchema" -> "true")

val df = spark.read.format("csv").options(formatOptions).load("s3://my-bucket/data-gen/delimited/202009121*")



