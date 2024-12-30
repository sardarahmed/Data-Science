#selenium to extract data from a website

#my aim is to extract only sale items from website and each article should have the following details:
#1. Name of the article
#2. Price of the article
#3. Discounted price of the article
#4. Discount percentage
#5. URL of
#6. Article image URL
#7. Article description
#8. Article category
#9. Article SKU
#10. Article brand
#11. Article color
#12. Article size
#13. Article material
#14. Article weight
#15. Article dimensions

# website used: https://pk.khaadi.com/

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time
import pandas as pd

#open the website
driver = webdriver.Chrome()
driver.get("https://pk.khaadi.com/sale/")
time.sleep(10)

#extracting the data
data = []
for i in range(1, 100):
        name = driver.find_element(By.XPATH, f"//*[@id='b3c75be0bf336b286bb80b5136']/div[2]/div[2]/a/h2").text
        data.append({
            "Name": name,

        })

df = pd.DataFrame(data)
df.to_csv("khaadi_sale.csv", index=False)
driver.quit()

