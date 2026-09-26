FROM prestashop/prestashop:latest

# 1. Increase PHP limits so the installer doesn't freeze at 50% on Render's free tier
RUN echo "max_execution_time = 300" > /usr/local/etc/php/conf.d/limits.ini \
 && echo "memory_limit = 512M" >> /usr/local/etc/php/conf.d/limits.ini \
 && echo "max_input_time = 300" >> /usr/local/etc/php/conf.d/limits.ini

# 2. Patch MyISAM to InnoDB globally for Aiven compatibility
RUN find /var/www/html -type f -name "*.php" -exec sed -i "s/ENGINE=MyISAM/ENGINE=InnoDB/g" {} + || true
RUN find /var/www/html -type f -name "*.php" -exec sed -i "s/'MyISAM'/'InnoDB'/g" {} + || true
RUN find /var/www/html -type f -name "*.php" -exec sed -i "s/\"MyISAM\"/\"InnoDB\"/g" {} + || true

# 3. Create a shell-bypass script to delete the install folder via your browser
RUN echo '<?php system("rm -rf install/"); echo "Install folder deleted! You can now access your store."; ?>' > /var/www/html/unlock.php
