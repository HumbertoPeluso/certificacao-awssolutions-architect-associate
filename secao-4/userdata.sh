#!bin/bash
yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
echo "<html><body><h2>Primeiro Servidor Web </h2><br> <h3>Endreço: $(hostname -f)</h3></body></html>" > /var/www/html/index.html