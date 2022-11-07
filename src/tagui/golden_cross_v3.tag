not blocked anymore, it was// visit website
https://www.marketbeat.com/stocks/golden-cross-stocks/
wait 2

click //*[@id="dropdownCountry"]
// check GB
click //*[@id="cphPrimaryContent_pnlFilterTable"]/div[1]/div[1]/div/ul/li[4]/label
wait 2
// check Europe
click //*[@id="cphPrimaryContent_pnlFilterTable"]/div[1]/div[1]/div/ul/li[5]/label
wait 2
// close dropd-own
click //*[@id="form1"]/div[3]
wait 30

// save table
//table //*[@id="cphPrimaryContent_pnlFilterTable"]/div[3]/div/table to ../../data/tagui/gc_tickers_`timestamp()`.csv
table //html/body/div[2]/main/article/form/div[4]/div[3]/div/table to ../../data/tagui/gc_tickers_`timestamp()`.csv