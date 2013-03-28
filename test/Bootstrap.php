<?php
/**
 * Created by JetBrains PhpStorm.
 * User: gwagner
 * Date: 3/22/13
 * Time: 9:58 AM
 * To change this template use File | Settings | File Templates.
 */

chdir(dirname(__FILE__).'/../');

// Setup autoloading
require dirname(__FILE__).'/../init_autoloader.php';

// Run the application!
Zend\Mvc\Application::init(require dirname(__FILE__).'/../config/application.config.php');