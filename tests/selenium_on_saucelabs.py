import unittest
from selenium import webdriver 
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions
from selenium.webdriver.chrome.options import Options as ChromeOptions
import time

class TestIframe(unittest.TestCase):
    def setUp(self): 
        username = "oauth-thinna732-c2b58"
        access_key = "f6437a76-c737-42aa-92a8-1751514dcc34"
        sauce_url = "https://" + username +":"+access_key+"@ondemand.apac-southeast-1.saucelabs.com:443/wd/hub"

        options = ChromeOptions()
        options.browser_version = 'latest'
        options.platform_name = 'Windows 10'
        sauce_options = {}
        options.set_capability('sauce:options', sauce_options)

        self.driver=webdriver.Remote(command_executor=sauce_url, options=options) 
        self.driver.execute_script("sauce:job-result=passed")

    def test_iframe_in_python(self):
        driver = self.driver
        driver.maximize_window()
        driver.get("https://www.w3schools.com/html/html_iframe.asp") 
        
        self.assertIn("Iframe", driver.title)
        h1element = driver.find_element(By.CSS_SELECTOR,'#main > h1') 
        self.assertIn("HTML Iframe", h1element.text)
                
        driver.execute_script("window.scrollTo(0, 300)")
        driver.switch_to.frame(driver.find_element(By.XPATH, '//*[@id="main"]/div[3]/iframe'))
        h1element = driver.find_element(By.CSS_SELECTOR,'#main > h1') 
        self.assertIn("HTML Tutorial", h1element.text)
        
        linkElement=driver.find_element(By.CSS_SELECTOR,'#topnav > div > div > a:nth-child(5)')
        linkElement.click()          
        
        time.sleep(3)        
        wait = WebDriverWait(driver, 20)
        h1element = driver.find_element(By.CSS_SELECTOR,'#main > h1')
        wait.until(expected_conditions.visibility_of(h1element))
        print(h1element.text)
        self.assertIn("JavaScript Tutorial", h1element.text)
        
        driver.switch_to.default_content()
        
    def tearDown(self):
        self.driver.close()
        
if __name__ == "__main__":
    unittest.main()