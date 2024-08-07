
# Sales Dashboard with Copilot

### Dashboard Link : https://app.powerbi.com/groups/ccf7275c-b162-4dd3-a686-a3d7494edf07/reports/43906740-f4a1-4ee7-ad2d-55b4954b33ec/68ce2a7a3c46980002ae?experience=power-bi

## Problem Statement

To Develop a comprehensive Power BI dashboard for bank loan analysis, offering real-time insights into loan performance. The dashboard categorizes loans as good or bad, facilitating detailed evaluation of loan quality, and providing in-depth analysis of loan seeker demographics, enabling a better understanding of customer profiles and trends.

### Steps followed 

- Step 1 : Open SQL Server and Uploaded the file within the newly created database.

- Step 2 : Changed the datatype of all the columns to varchar(---) where it was nvarchar(50)

- Step 3 : All the calculations were performed in the SQL Server to cross-check the SQL results with the powerBI calculations. 

Snaps of all the queries performed in the SQL Server and their results. (The script of queries is available at Github account)

![Screenshot 2024-08-02 202447](https://github.com/user-attachments/assets/2a82995f-6859-42fc-a5b3-1aee110ba77d)
![Screenshot 2024-08-02 202945](https://github.com/user-attachments/assets/d409a613-46d9-4ba4-9854-aa0fcda813e5)

- Step 4 : Load data into Power BI Desktop, connecting through SQL Server.

        
- Step 5 : Open the power query editor & in the view tab under the Data Preview section, and check on the "column distribution", "column quality" & "column profile" options.

- Step 6 : Also since by default, the profile will be opened only for 1000 rows you need to select "column profiling based on the entire dataset".   

- Step 7 : It was observed that within columns empty values were present, which were removed. The first columns are used as headers and data is uploaded to powerBI.

- Step 8 : A separate date table was created for time references and month numbers and names were extracted for future references.
        The following DAX expression was used to create a date table and month.

        Date Table = CALENDAR(min('Bank Loan DB'[issue_date]), MAX('Bank Loan DB'[issue_date]))
        Month = FORMAT('Date Table'[Date], "MMM")
        MonthNum = month('Date Table'[Date].[Date])

- Step 9 : The one-to-many relationship was created between date table and bank loan data.

- Step 10 : The Power BI report contains 3 different pages i.e.

        1. Summary Page
        2. Overview Page
        3. Details Page

- Step 11 : Different measures were created: 

        A) Total Loan Applications: 
                Total Loan Applications = COUNT('Bank Loan DB'[id])

        B) Total Funded Amount:
                Total Funded Amount = SUM('Bank Loan DB'[loan_amount])

        C) Total Amount Received: 
                Total Amount Received = SUM('Bank Loan DB'[total_payment])

        D) Average Interest Rate:
                Avg Interest Rate = AVERAGE('Bank Loan DB'[int_rate])

        E) Average Debt-to-Income Ratio (DTI): 
                Avg DTI = AVERAGE('Bank Loan DB'[dti])

        F) Month-to-Date Debt-to-Income Ratio (DTI): 
                MTD DTI = CALCULATE(TOTALMTD([Avg DTI], 'Date Table'[Date].[Date]))

        G) Month-to-Date Funded Amount:
                MTD Funded Amount = CALCULATE(TOTALMTD([Total Funded Amount], 'Date Table'[Date].[Date]))

        H) Month-to-Date Interest Rate:
         TD Interest Rate = CALCULATE(TOTALMTD([Avg Interest Rate], 'Date Table'[Date].[Date]))

        I) Month-to-Date Loan Applications:
                MTD Loan Applications = CALCULATE(TOTALMTD([Total Loan Applications], 'Date Table'[Date].[Date]))

        J) Month-to-Date Total Amount Received:
                MTD Total Amount Received = CALCULATE(TOTALMTD([Total Amount Received], 'Date Table'[Date].[Date]))

        K) Previous-Month-to-Date Debt-to-Income Ratio (DTI):
                PMTD DTI = CALCULATE([MTD DTI], DATESMTD(DATEADD('Date Table'[Date].[Date],-1,MONTH)))

        L) Previous-Month-to-Date Interest Rate:
                PMTD Interest Rate = CALCULATE([MTD Interest Rate], DATESMTD(DATEADD('Date Table'[Date].[Date],-1,MONTH)))

        M) Previous-Month-to-Date Loan Applications:
                PMTD Loan Applications = CALCULATE([Total Loan Applications], DATESMTD(DATEADD('Date Table'[Date].[Date],-1,MONTH)))

        N) Previous-Month-to-Date Total Amount Received:
                PMTD Total Amount Received = CALCULATE([MTD Total Amount Received], DATESMTD(DATEADD('Date Table'[Date].[Date],-1,MONTH)))

        O) Previous-Month-to-Date Total Funded Amount:
                PMTD Total Funded Amount = CALCULATE([Total Funded Amount], DATESMTD(DATEADD('Date Table'[Date].[Date],-1,MONTH)))

        P) Month-on-Month Debt-to-Income Ratio (DTI):
                MoM DTI = ([MTD DTI]-[PMTD DTI])/[PMTD DTI]

        Q) Month-on-Month Funded Amount:
                MoM Funded Amount = ([MTD Funded Amount]-[PMTD Total Funded Amount])/[PMTD Total Funded Amount]

        R) Month-on-Month Interest Rate:
                MoM Interest Rate = ([MTD Interest Rate]-[PMTD Interest Rate])/[PMTD Interest Rate]

        S) Month-on-Month Loan Applications
                MoM Loan Applications = ([MTD Loan Applications]-[PMTD Loan Applications])/[PMTD Loan Applications]

        T) Month-on-Month Total Amount Received:
                MoM Total Amount Received = ([MTD Total Amount Received]-[PMTD Total Amount Received])/[PMTD Total Amount Received]

        U) Bad Loan Applications
                Bad Loan Applications = CALCULATE([Total Loan Applications], 'Bank Loan DB'[Good vs Bad Loans]= "Bad Loans")
                
        V) Bad Loan Funded Amount
                Bad Loan Funded Amount = CALCULATE([Total Funded Amount], 'Bank Loan DB'[Good vs Bad Loans]= "Bad Loans")

        W) Bad Loan Received Amount
                Bad Loan Received Amount = CALCULATE([Total Amount Received], 'Bank Loan DB'[Good vs Bad Loans]= "Bad Loans")

        X) Good Loan Applications
                Good Loan Applications = CALCULATE([Total Loan Applications], 'Bank Loan DB'[Good vs Bad Loans]= "Good Loans")

        Y) Good Loan Funded Amount
                Good Loan Funded Amount = CALCULATE([Total Funded Amount], 'Bank Loan DB'[Good vs Bad Loans]= "Good Loans")

        Z) Good Loan Received Amount
                Good Loan Received Amount = CALCULATE([Total Amount Received], 'Bank Loan DB'[Good vs Bad Loans]= "Good Loans")

- Step 12 : A separate measure table was created to keep all the calculated measures in one place. 

- Step 13 : KPI Cards were used to represent the below metrics:

        A) Total Loan Applications along with "Month-to-Date Loan Applications", and "Month-on-Month Loan Applications"

        B) Total Funded Amount along with "Month-to-Date Funded Amount", and "Month-on-Month Funded Amount"

        C) Total Amount Received along with "Month-to-Date Total Amount Received", and "Month-on-Month Total Amount Received"

        D) Average Interest Rate along with "Month-to-Date Interest Rate", and "Month-on-Month Interest Rate"

        E) Average Debt-to-Income Ratio (DTI) along with "Month-to-Date Debt-to-Income Ratio (DTI)", and "Month-on-Month Debt-to-Income Ratio (DTI)"

- Step 14 : KPI Cards(New) were used to represent the below metrics:

        A) "Good Loan Applications", "Good Loan Funded Amount", and "Good Loan Received" Amount

        B) "Bad Loan Applications", "Bad Loan Funded Amount", and "Bad Loan Received Amount"

- Step 15 : A new group was created named "Good vs Bad Loans" in which Good Loan includes where Loan status is "fully Paid" or "Current" and Bad Loan includes where loan status is "Charged Off"
- Step 16 : Two new measures were created for the Donut Chart to calculate good loan % and bad loan %

        Good Loan % = (CALCULATE([Total Loan Applications], 'Bank Loan DB'[Good vs Bad Loans]= "Good Loans"))/[Total Loan Applications]

        Bad Loan % = (CALCULATE([Total Loan Applications], 'Bank Loan DB'[Good vs Bad Loans]= "Bad Loans"))/[Total Loan Applications]

- Step 17 : A new parameter was created to change the area chart between "Total Loan Applications" "Total Funded Amount", and "Total Amount Received"

- Step 18 : Visuals used to represent loans as per different categories are mentioned below,

1. SUMMARY PAGE:

        (A) "Good Loan %" and "Bad Loan %" (Donut Chart)

        (B) "Loan Status", "Total Loan Applications", "Total Funded Amount", "MTD Funded Amount", "MTD Total Amount Received", "Avg Interest Rate", "Avg DTI" (Table)
  
        (C) "State", "Grade", and "Purpose" (Slicer)

2. OVERVIEW PAGE:

        (A) "Total Loan Applications" OR "Total Funded Amount", OR "Total Amount Received" by Month
  
        (B) Total Funded Amount by States (Shape Map)

        (C) Total Funded Amount by Term (Donut Chart)

        (D) Total Funded Amount by Employee Length (Stacked Bar Chart)

        (E) Total Funded Amount by Purpose (Stacked Bar Chart)

        (F) Total Funded Amount by Home Ownership (Treemap)

        (G) "Select Measure", "State", "Grade", and "Good vs Bad Loan" (Slicer)

2. DETAILS PAGE:

        (A) "ID", "Purpose", "Home Ownership", "Grade", "Sub-Grade", "Issue Date", "Funded Amount", "Int Rate", "Installation", "Amount Received" (Table)

        (B) "State", "Grade", and "Good vs Bad Loan" (Slicer)


- Step 19 : Page Navigator was added to move through the pages

- Step 20 : A Page Navigator was added to move between 'Dashboard' and 'Salesperson Detail'.

 - Step 21 : The bank logo was added and the final view was ready

 - Step 22 : The report was then published to Power BI Service.
 
 ![Screenshot 2024-08-07 023901](https://github.com/user-attachments/assets/32851170-478b-47b9-af96-285ce2aadda6)
 
 # Report Snapshot (Power BI DESKTOP)

![Screenshot 2024-08-07 024110](https://github.com/user-attachments/assets/cb0f2985-b64a-4c72-8cb6-c6698166fa32)

![Screenshot 2024-08-07 024127](https://github.com/user-attachments/assets/a8687507-6bc2-4afd-b84a-dc7da76ae4ca)

![Screenshot 2024-08-07 024152](https://github.com/user-attachments/assets/24e508b2-9d54-42aa-8d9b-61c7877bdfcd)


# Insights

Overview:

• Total Loan Applications: 38.58K

• Total Funded Amount: $435.8M

• Total Amount Received: $473.1

• Average Interest Rate: 12%

• Average Debt-to-Income Ratio (DTI): 13.3%

• MoM increase in loan applications is 6.9%.

• MoM increase in loan amount is 13%.

Scope:

• Average DTI is 13.3%, which is way below the good DTI score i.e. 35%, which means there is more loan potential in the market.

• Bad loans account for 13.8% of total loans. The target can be to bring it down to below 10%.

• Total lost amount due to bad loans is 32.2M.

• 53.3% (232.46M) of the total loan amount is taken for debt consolidation. 
 
• States with a bad loan percentage higher than average i.e. 13.8% should try to reduce it to the average.

