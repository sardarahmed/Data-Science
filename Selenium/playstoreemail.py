#i want to extract google playstore email from the website

from selenium import webdriver
from selenium.webdriver.common.by import By

from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

import time
import pandas as pd
import os
#open the website


# I want email of developer on playstore website in which I am targetting the app " Wallpaper" incluing words.
# but app should have less than 1000 downloads
driver = webdriver.Chrome()
driver.get("https://play.google.com/store/apps")
time.sleep(2)


#now search for the app "Wallpaper" and select only those apps which have less than 1000 downloads
def search_icon():
    search = driver.find_element(By.XPATH, '//*[@id="kO001e"]/header/nav/div/div[1]/button/i')
    search.click()
search_icon()

wallpapers=[
    "HD Wallpapers",
    "4K Wallpapers",
    "Live Wallpapers",
    "Mobile Wallpapers",
    "Aesthetic Wallpapers",
    "Backgrounds",
    "Wallpapers and Themes",
    "Islamic Wallpapers",
    "Quran Wallpapers",
    "Nature Wallpapers",
    "Flower Wallpapers",
    "Scenery Wallpapers",
    "Love Wallpapers",
    "Couple Wallpapers",
    "Pakistani Wallpapers",
    "Cultural Wallpapers",
    "Abstract Wallpapers",
    "Minimalist Wallpapers",
    "Dark Wallpapers",
    "Neon Wallpapers",
    "Cartoon Wallpapers",
    "Anime Wallpapers",
    "Ramadan Wallpapers",
    "Eid Wallpapers",
    "Independence Day Wallpapers (14th August)",
    "New Year Wallpapers",
    "Customized Wallpapers",
    "Photo Wallpapers",
    "Text Wallpapers",
    "3D Wallpapers",
    "Winter Wallpapers",
    "Summer Wallpapers",
    "Rain Wallpapers",
    "Truck Art Wallpapers",
    "Lahore Wallpapers",
    "Karachi Wallpapers",
    "Pakistani Flag Wallpapers",
    "Desi Wallpapers"]

#search keyword wallpaper
def search_wallpaper():
    search = driver.find_element(By.XPATH, '//*[@id="kO001e"]/header/nav/c-wiz/div/div/label/input')
    search.send_keys("pti wallpaper")
    search.send_keys(Keys.RETURN)
    time.sleep(2)

search_wallpaper()



#now I want it stores all app name  on search page and then click one by one on each app and extract email as per condition
#don't repeat names of app, only unique names
def store_app():
    app_name = []
    for i in range(1, 30):
        app = driver.find_elements(By.CLASS_NAME, 'DdYX5')[i]
        app_name.append(app.text)
        #if app name = 30 then stop
        if i == 30:
            break
        print(app_name)
        df = pd.DataFrame(app_name)
        df.to_csv("app_names.csv", index=False)

    emails = []
    urls = []
    #click on each app name from app_names,csv and check the number of downloads
    time.sleep(2)
    for i in range(1, 10):
        app = driver.find_elements(By.CLASS_NAME, 'DdYX5')[i]
        app.click()
        time.sleep(2)
        downloads = driver.find_element(By.CLASS_NAME, 'ClM7O')
        downloads = downloads.text
        print(downloads)
        time.sleep(2)
        if "500+" in downloads or "1K+" in downloads or "50+" in downloads or "0+" in downloads or "10+" in downloads or "1B+" in downloads:
            #click on app support
            app_support = driver.find_element(By.XPATH, '//*[@id="developer-contacts-heading"]/div[2]/button/i')
            app_support.click()
            time.sleep(2)
            #click on developer email
            app_email = driver.find_element(By.CLASS_NAME, 'pSEeg')
            email = app_email.text
            print(email)
            emails.append(
                {
                    "Email": email
                }
            )
            time.sleep(1)
            # i want to extract app email also from the website
            url = driver.current_url
            print(url)
            urls.append(
                {
                    "App URL": url
                }
            )
            driver.back()
            time.sleep(2)

        else:
            driver.back()
            time.sleep(2)

    email_df = pd.DataFrame([emails, urls])
    if not os.path.isfile("app_emails.csv"):
        email_df.to_csv("app_emails.csv", index=False)
    else:
        email_df.to_csv("app_emails.csv", mode='a', header=False, index=False)
    time.sleep(1)
    #clear previous search
    search_bar = driver.find_element(By.XPATH, '//*[@id="kO001e"]/header/nav/c-wiz/div/div/label/input').clear()
    time.sleep(2)


store_app()
#run the loop for all wallpapers





'''ind  = 0
while ind < len(wallpapers):
    search_wallpaper()
    time.sleep(2)
    store_app()
    time.sleep(2)
    ind += 1'''






