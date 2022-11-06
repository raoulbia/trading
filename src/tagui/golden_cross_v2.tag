// This flow ...

//Step 1: Create CSV file with Date stamp in filename and headers Name , Price
dump TICKER,NAME,INDUSTRY,EXCHANGE,SMA200PRICE,PRICE,VOLUME to ../../data/tagui/gc_tickers_`timestamp()`.csv


// visit website
https://www.marketbeat.com/stocks/golden-cross-stocks/
wait 2

// select country
for j in 1 to 5
    if j equals to 1
        exchange = 'NYSE'
    if j equals to 4
        exchange = 'GB'
        click //*[@id="dropdownCountry"]
        // uncheck NYSE
        click //*[@id="cphPrimaryContent_pnlFilterTable"]/div[1]/div[1]/div/ul/li[1]/label
        // check GB
        click //*[@id="cphPrimaryContent_pnlFilterTable"]/div[1]/div[1]/div/ul/li[4]/label
        // close drop down menu
        click //*[@id="form1"]/div[3]
    if j equals to 5
        exchange = 'EU'
        click //*[@id="dropdownCountry"]
        // uncheck GB
        click //*[@id="cphPrimaryContent_pnlFilterTable"]/div[1]/div[1]/div/ul/li[4]/label
        // check Europe
        click //*[@id="cphPrimaryContent_pnlFilterTable"]/div[1]/div[1]/div/ul/li[5]/label
        // close drop down menu
        click //*[@id="form1"]/div[3]
    if j equals to 2
        continue
    if j equals to 3
        continue
    // wait until page fully loaded
    wait 30
    // select industry
    for i from 1 to 19
        click //*[@id="dropdownSector"]/span[2]
        read //*[@id="cphPrimaryContent_pnlFilterTable"]/div[1]/div[2]/div/ul/li[`i`]/label/text() to industry
        if i equals to 1    
            click //*[@id="cphPrimaryContent_pnlFilterTable"]/div[1]/div[2]/div/ul/li[`i`]/label
            click //*[@id="form1"]/div[3]
        else
            // uncheck previous selection
            prev = i - 1
            click //*[@id="cphPrimaryContent_pnlFilterTable"]/div[1]/div[2]/div/ul/li[`prev`]/label
            click //*[@id="cphPrimaryContent_pnlFilterTable"]/div[1]/div[2]/div/ul/li[`i`]/label
            click //*[@id="form1"]/div[3]

        // wait until page fully loaded
        wait 30
        // sort by volume desc
        click //*[@id="cphPrimaryContent_pnlFilterTable"]/div[3]/div/table/thead/tr/th[5]
        click //*[@id="cphPrimaryContent_pnlFilterTable"]/div[3]/div/table/thead/tr/th[5]

        // count rows
        rows = count('//*[@id="cphPrimaryContent_pnlFilterTable"]/div[3]/div/table/tbody/tr') 
        if rows > 0
            echo `rows`
            // get data for each row
            for row from 1 to rows
                if exist('//*[@id="cphPrimaryContent_pnlFilterTable"]/div[3]/div/table/tbody/tr[`row`]/td[1]/a/div[2]')
                    read //*[@id="cphPrimaryContent_pnlFilterTable"]/div[3]/div/table/tbody/tr[`row`]/td[1]/a/div[2] to ticker
                    if exist('//*[@id="cphPrimaryContent_pnlFilterTable"]/div[3]/div/table/tbody/tr[`row`]/td[1]/a/div[3]')
                        read //*[@id="cphPrimaryContent_pnlFilterTable"]/div[3]/div/table/tbody/tr[`row`]/td[1]/a/div[3] to name
                else
                    if exist('//*[@id="cphPrimaryContent_pnlFilterTable"]/div[3]/div/table/tbody/tr[`row`]/td[1]/a/div[1]')
                        read //*[@id="cphPrimaryContent_pnlFilterTable"]/div[3]/div/table/tbody/tr[`row`]/td[1]/a/div[1] to ticker
                        if exist('//*[@id="cphPrimaryContent_pnlFilterTable"]/div[3]/div/table/tbody/tr[`row`]/td[1]/a/div[2]')
                            read //*[@id="cphPrimaryContent_pnlFilterTable"]/div[3]/div/table/tbody/tr[`row`]/td[1]/a/div[2] to name

                read //*[@id="cphPrimaryContent_pnlFilterTable"]/div[3]/div/table/tbody/tr[`row`]/td[2]/text() to price
                read //*[@id="cphPrimaryContent_pnlFilterTable"]/div[3]/div/table/tbody/tr[`row`]/td[4]/text() to sma200price
                read //*[@id="cphPrimaryContent_pnlFilterTable"]/div[3]/div/table/tbody/tr[`row`]/td[5]/text() to volume

                write `csv_row([ticker,name,industry,exchange,sma200price,price,volume])` to ../../data/tagui/gc_tickers_`timestamp()`.csv