import unittest
from selenium import webdriver 
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions
import time

class TestIframe(unittest.TestCase):
    def setUp(self):
        self.driver = webdriver.Chrome()
        
    def test_iframe_in_python(self):
        driver = self.driver
        driver.maximize_window()
        driver.get("https://www.w3schools.com/html/html_iframe.asp") 
        
        self.assertIn("Iframe", driver.title)
        h1element = driver.find_element(By.CSS_SELECTOR,'#main > h1') 
        self.assertIn("HTML Iframe", h1element.text)
        
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