# -*- coding: utf-8 -*-
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import NoAlertPresentException
import unittest, time, re

class Drupal(unittest.TestCase):
    def setUp(self):
        self.driver = webdriver.Firefox()
        self.driver.implicitly_wait(30)
        self.base_url = "http://drupal/"
        self.verificationErrors = []
        self.accept_next_alert = True
    
    def test_drupal(self):
        driver = self.driver
        driver.get("http://drupal/")
        for i in range(60):
            try:
                if "Welcome to default" == driver.find_element_by_id("page-title").text: break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        driver.find_element_by_id("edit-name").clear()
        driver.find_element_by_id("edit-name").send_keys("admin")
        driver.find_element_by_id("edit-pass").clear()
        driver.find_element_by_id("edit-pass").send_keys("changeme")
        driver.find_element_by_id("edit-submit").click()
        for i in range(60):
            try:
                if "Welcome to default" == driver.find_element_by_id("page-title").text: break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        driver.find_element_by_css_selector("li.last.collapsed > a").click()
        driver.find_element_by_css_selector("li.logout.last > a").click()
        for i in range(60):
            try:
                if "Welcome to default" == driver.find_element_by_id("page-title").text: break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
    
    def is_element_present(self, how, what):
        try: self.driver.find_element(by=how, value=what)
        except NoSuchElementException, e: return False
        return True
    
    def is_alert_present(self):
        try: self.driver.switch_to_alert()
        except NoAlertPresentException, e: return False
        return True
    
    def close_alert_and_get_its_text(self):
        try:
            alert = self.driver.switch_to_alert()
            alert_text = alert.text
            if self.accept_next_alert:
                alert.accept()
            else:
                alert.dismiss()
            return alert_text
        finally: self.accept_next_alert = True
    
    def tearDown(self):
        self.driver.quit()
        self.assertEqual([], self.verificationErrors)

if __name__ == "__main__":
    unittest.main()
