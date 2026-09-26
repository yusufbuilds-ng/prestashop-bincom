FROM prestashop/prestashop:latest

# Increase PHP limits to prevent installer timeouts on free cloud tiers
RUN echo "max_execution_time = 300" > /usr/local/etc/php/conf.d/limits.ini \
 && echo "memory_limit = 512M" >> /usr/local/etc/php/conf.d/limits.ini \
 && echo "max_input_time = 300" >> /usr/local/etc/php/conf.d/limits.ini

# Global MyISAM to InnoDB patch
RUN find /var/www/html -type f -name "*.php" -exec sed -i "s/ENGINE=MyISAM/ENGINE=InnoDB/g" {} + || true
RUN find /var/www/html -type f -name "*.php" -exec sed -i "s/'MyISAM'/'InnoDB'/g" {} + || true
RUN find /var/www/html -type f -name "*.php" -exec sed -i "s/\"MyISAM\"/\"InnoDB\"/g" {} + || true
