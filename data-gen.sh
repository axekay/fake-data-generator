#!/bin/bash
# $1 -> seed
# $2 -> records per iteration
# $3 -> s3 directory path
# $4 -> number of iterations

set -e

echo "downloading utility jar from s3"
jar_name=fake-data-generator-uber.jar
rm -f $jar_name
aws s3 cp s3://my-bucket/data-gen/utility/$jar_name $jar_name
echo "utility jar downloaded"
for i in $(seq $4)
do
 test -f stopit && echo "stopit file found, hence breaking the loop" && break
 echo "iteration $i"
 file_name=$(date +%Y%m%d%H%M%S).csv
 echo "generating $2 records with seed=$1 in $file_name file"
 java -cp fake-data-generator-uber.jar com.axekay.faker.MainClass $1 $2 > $file_name
 echo "file generated. compression started"
 gzip $file_name
 echo "compression done. uploading to s3"
 aws s3 cp $file_name.gz $3
 rm $file_name.gz
 echo "upload complete. file deleted"
done
