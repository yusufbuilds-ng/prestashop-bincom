FROM prestashop/prestashop:latest

# Patch all database and installer files to replace MyISAM with InnoDB globally
RUN find /var/www/html -type f -name "*.php" -exec sed -i "s/ENGINE=MyISAM/ENGINE=InnoDB/g" {} + || true
RUN find /var/www/html -type f -name "*.php" -exec sed -i "s/'MyISAM'/'InnoDB'/g" {} + || true
RUN find /var/www/html -type f -name "*.php" -exec sed -i "s/\"MyISAM\"/\"InnoDB\"/g" {} + || true
