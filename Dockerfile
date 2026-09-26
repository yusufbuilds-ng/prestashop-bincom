FROM prestashop/prestashop:latest

# Patch PrestaShop's database check class to use InnoDB instead of MyISAM
RUN sed -i "s/\$engine = 'MyISAM';/\$engine = 'InnoDB';/g" /var/www/html/classes/db/DbPDO.php || true
RUN sed -i "s/\$engine = 'MyISAM';/\$engine = 'InnoDB';/g" /var/www/html/classes/db/DbMySQLi.php || true
