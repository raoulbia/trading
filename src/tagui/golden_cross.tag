// This flow ...

//Step 1: Create CSV file with Date stamp in filename and headers Name , Price
dump TICKER,NAME,INDUSTRY,VOLUME,PRICE to ../../data/tagui/gc_tickers_`timestamp()`.csv


// visit website
https://www.marketbeat.com/stocks/golden-cross-stocks/
wait 2

// select country
click //*[@id="dropdownCountry"]
wait 1
click //*[@id="cphPrimaryContent_pnlFilterTable"]/div[1]/div[1]/div/ul/li[2]/label
wait 1
click //*[@id="cphPrimaryContent_pnlFilterTable"]/div[1]/div[1]/div/ul/li[4]/label
wait 1
click //*[@id="cphPrimaryContent_pnlFilterTable"]/div[1]/div[1]/div/ul/li[5]/label
wait 1
click //*[@id="dropdownCountry"]
wait 1

// wait until page fully loaded
wait 30
// select industry
for i from 1 to 19
    click //*[@id="dropdownSector"]/span[2]
    read //*[@id="cphPrimaryContent_pnlFilterTable"]/div[1]/div[2]/div/ul/li[`i`]/label/text() to industry
    click //*[@id="cphPrimaryContent_pnlFilterTable"]/div[1]/div[2]/div/ul/li[`i`]/label
    click //*[@id="form1"]/div[3]

    // wait until page fully loaded
    wait 30
    // sort by volume desc
    click //*[@id="cphPrimaryContent_pnlFilterTable"]/div[3]/div/table/thead/tr/th[5]
    click //*[@id="cphPrimaryContent_pnlFilterTable"]/div[3]/div/table/thead/tr/th[5]

    // count rows
    rows = count('//*[@id="cphPrimaryContent_pnlFilterTable"]/div[3]/div/table/tbody/tr')
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
        read //*[@id="cphPrimaryContent_pnlFilterTable"]/div[3]/div/table/tbody/tr[`row`]/td[5]/text() to volume

        write `csv_row([ticker, name, industry, volume, price])` to ../../data/tagui/gc_tickers_`timestamp()`.csv

    // table //*[@id="cphPrimaryContent_pnlFilterTable"] to golden_crosses.csv
