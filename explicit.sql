select lca.personal_offer_code as poc,dm.first_name,dmc.Product,dmc.group_description AS Group_Description,dmc.creative_description AS Creative_Description, dmc.creative_code AS Creative_Code,dm.poc AS Personal_Offer_Code,dmc.Campaign_Year, dmc.Campaign_Month,dmc.Campaign_Estimated_Start, dmc.Campaign_Actual_Start,dmc.Campaign_End_Date,dmc.Campaign_Actual_End_Date ,dm.Mail_Campaigns,dm.Mail_Products,dm.Number_Of_Mailings, 
    dm.Loan_Mailings_Last_9_Sends,dm.Card_Mailings_Last_9_Sends,dm.Mailings_Last_9_Sends,
    dm.FICO_Score, dm.Loan_Response_Score, dm.Loan_Default_Score, dm.Income_Score,dm.Bankruptcy_Score,dm.Vantage_Score,dm.Months_Since_Last_CC,dm.Months_Since_Last_Credit_Inquiry,dm.Number_Of_Bank_Installment_Trades_Opened_Last_6_Months, dm.Months_On_File,dm.Open_Satisfactory_Trades,dm.Number_Of_Non_Student_Trades
    ,dm.Total_Revolving_Banking_Balance, dm.Monthly_Payment_On_Revolving_Balance, dm.Total_Revolving_Finance_Balance,dm.Total_Revolving_Balance, dm.Total_Trade_Balance, dm.Months_Since_Most_Recent_Trade
    ,DATE_PART('year',lca.created_time) AS App_Year,
    DATE_PART('month',lca.created_time) AS App_Month, date_trunc('day', lca.created_time) AS App_Date,COALESCE(lca.returning_customer_status,'unknown') AS Customer_Status,
    case when 
        lca.coupon_code is not null and lca.direct_mail_flag = TRUE then 'Direct Mail' 
        WHEN UPPER(lca.source) like UPPER('%ppc%') THEN 'PPC'
        WHEN UPPER(lca.source) = UPPER('massive-email') THEN 'Massive Email'
        WHEN UPPER(lca.source) = UPPER('bmg-email') THEN 'BMG Email'
        WHEN UPPER(lca.source) = UPPER('avant_digital_prescreen_prefill') THEN 'ODS Avant'
        WHEN UPPER(lca.source) like UPPER('cc-email%') THEN 'Portfolio'
        WHEN UPPER(lca.source) like UPPER('fb-ig%') THEN 'Social Media'
        WHEN UPPER(lca.source) like UPPER('%creditkarma%') THEN 'Credit Karma'
        WHEN UPPER(lca.source) = UPPER('ck') THEN 'Credit Karma'
        WHEN UPPER(lca.source) like UPPER('%credit_karma%') THEN 'Credit Karma'
        WHEN UPPER(lca.source) like UPPER('lendingtree%') THEN 'Lending Tree'
        WHEN UPPER(lca.source) = UPPER('LT') THEN 'Lending Tree'
        WHEN UPPER(lca.source) like UPPER('experian%') THEN 'Experian'
        WHEN UPPER(lca.source) like UPPER('creditsesame%') THEN 'Credit Sesame'
        WHEN UPPER(lca.source) like UPPER('credit_sesame%') THEN 'Credit Sesame'
        WHEN UPPER(lca.source) like UPPER('comparecards%') THEN 'Compare Cards'
        WHEN UPPER(lca.source) like UPPER('magnifymoney%') THEN 'Magnify Money'
        WHEN UPPER(lca.source) like UPPER('nerdwallet%') THEN 'Nerd Wallet'
        WHEN UPPER(lca.source) like UPPER('nerd_wallet%') THEN 'Nerd Wallet'
        WHEN UPPER(lca.source) like UPPER('simpletuition%') THEN 'Simple Tuition'
        WHEN UPPER(lca.source) like UPPER('transunion%') THEN 'TransUnion'
        WHEN UPPER(lca.source) like UPPER('bankrate%') THEN 'Bank Rate'
        WHEN UPPER(lca.source) like UPPER('creditcardsdotcom%') THEN 'CreditCards.com'
        WHEN UPPER(lca.source) like UPPER('creditdotcom%') THEN 'Credit.com'
        WHEN UPPER(lca.source) like UPPER('evenfinancial%') THEN 'Evenfinancial'
        WHEN UPPER(lca.source) like UPPER('mint%') THEN 'Mint'
        WHEN UPPER(lca.source) like UPPER('turbo%') THEN 'Turbo'
        WHEN UPPER(lca.source) like UPPER('cardratings%') THEN 'Cardratings'
        WHEN UPPER(lca.source) like UPPER('lendedu%') THEN 'LendEDU'
        WHEN UPPER(lca.source) like UPPER('creditsoup%') THEN 'Credit Soup'
        WHEN UPPER(lca.source) like UPPER('wallethub%') THEN 'Wallet Hub'
        WHEN UPPER(lca.source) like UPPER('westlake%') THEN 'Westlake'
        WHEN UPPER(lca.source) like UPPER('upturn%') THEN 'Upturn'
        WHEN UPPER(lca.source) like UPPER('usnews%') THEN 'US News'
        WHEN UPPER(lca.source) like UPPER('forbes%') THEN 'Forbes'
        WHEN UPPER(lca.source) like UPPER('%simpledollar%') THEN 'The Simple Dollar'
        WHEN UPPER(lca.source) like UPPER('%mastercard%') THEN 'Mastercard'
        WHEN UPPER(lca.source) like UPPER('%massive%') THEN 'Massive'
        WHEN UPPER(lca.source) like UPPER('%google%') THEN 'Google'
        WHEN UPPER(lca.source) like UPPER('%bing%') THEN 'Bing'
        WHEN UPPER(lca.source) like UPPER('commission%') THEN 'Commission Junction'
        WHEN UPPER(lca.source) like UPPER('organic') THEN 'Organic'
        WHEN UPPER(lca.source) like UPPER('%email%') THEN 'Other Email'
        else lca.source END AS Marketing_Source, lca.loan_purpose,lca.employment_industry, lca.income_type, lca.applied_cd_monthly_net_income,
    lca.housing_ownership_type,lca.monthly_housing_payment_amount,TRUNCATE(lca.applied_cd_fico_score,-1) AS Applied_FICO_Score,lca.prefunding_dti,lca.income_model_score,lca.fraud_credit_model_score ,lca.requested_loan_amount ,
    lca.loan_amount , lca.loan_term, lca.interest_rate, lca.status AS Application_Status,
    case when lca.issued_flag = True then 1 else 0 END AS Loan_Issued, loan.loan_amount AS Total_Issuance, loan.status AS Current_Loan_Status, 
    lcd.credit_decline_reasons, lcd.product_decline_reasons, lcd.eligibility_decline_reasons,  lcd.risk_segment, lcd.product_rating, lcd.eligibility_approved_flag, lcd.credit_approved_flag, lcd.product_approved_flag,
    (EXTRACT(DAY FROM DATE_SUB(lca.issuance_decision_time, lca.created_time))* 24)  + (EXTRACT(HOUR FROM DATE_SUB(lca.issuance_decision_time, lca.created_time))) + (CAST(EXTRACT(MINUTE FROM DATE_SUB(lca.issuance_decision_time, lca.created_time))AS NUMERIC)/60) AS Time_To_Issuance,
    case when lca.issuance_decision_time IS NOT NULL then 'Issued' when lca.completed_view_count > 0  then 'Completed View' when lca.enter_verification_time IS NOT NUll then 'Entered Verification' when lca.additional_information_submit_count  > 0 then 'Additional Info Submitted' when lca.additional_information_view_count  > 0 then 'Additional Info Viewed' when 
    lca.bank_account_submit_count  > 0 then 'Bank Account Submitted' when 
    lca.bank_account_view_count  > 0 then 'Bank Account Viewed' when lca.contract_submit_count  > 0 then 'Contract Submitted' when lca.contract_view_count  > 0 then 'Contract Viewed' when
    lca.rates_terms_submit_count  > 0 then 'Rates & Terms Submitted' when lca.rates_terms_view_count  > 0 then 'Rates & Terms Viewed' when lca.personal_submit_time  IS NOT NULL then 'Personal Info Submitted' when lca.personal_view_time  IS NOT NULL then 'Personal Info Viewed' else 'Immediate Bounce' END AS Last_Action_Taken,
    dm.zip_code
    from 
    (SELECT dm.creative_type, dme.timesmailed AS Mail_Campaigns,dm.timesmailed_product AS Mail_Products,COALESCE(LENGTH(regexp_replace(dme.timesmailed, '[a-zA-Z0-9]', '')) + 1,0) AS Number_Of_Mailings, 
    dme.times_mailed_loan_last_9_sends AS Loan_Mailings_Last_9_Sends,dme.times_mailed_card_last_9_sends AS Card_Mailings_Last_9_Sends,dme.times_mailed_last_9_sends AS Mailings_Last_9_Sends,
    TRUNC(dme.fico_score,-1) AS FICO_Score, TRUNC(dme.pl_response_400_score,3) AS Loan_Response_Score, TRUNC(dme.pl_default_520_score,2) AS Loan_Default_Score, TRUNC(dme.bankruptcy_200_score,2) AS Bankruptcy_Score,TRUNC(dme.income_300_score,-2) AS Income_Score,dme.cvtg03 AS Vantage_Score,dm.bc21s AS Months_Since_Last_CC,dm.g102s AS Months_Since_Last_Credit_Inquiry,dm.bi05 AS Number_Of_Bank_Installment_Trades_Opened_Last_6_Months,COALESCE(dm.g106s,0) AS Months_On_File,COALESCE(dm.at03s,0) AS Open_Satisfactory_Trades,COALESCE(dm.at01 - COALESCE(dm.st01s,0),0) AS Number_Of_Non_Student_Trades,dm.consumerid,dm.poc, dm.bpid,dm.first_name, dm.last_name,dm.address, dm.state, dm.zip_code,
    COALESCE(dm.br33,0) as Total_Revolving_Banking_Balance, COALESCE(dm.attr16,0) AS Monthly_Payment_On_Revolving_Balance, COALESCE(dm.fr33,0) Total_Revolving_Finance_Balance,COALESCE(dm.re33,0) as Total_Revolving_Balance, COALESCE(dm.at99,0) as Total_Trade_Balance, COALESCE(dm.at21,0) as Months_Since_Most_Recent_Trade
    from avant.prod.intermediate.dw.dw_orig.direct_mail_prospect_mailed_by_send_campaign as dm
    inner join 
    (select distinct dme.consumerid, dme.bpid,dme.timesmailed,dme.times_mailed_loan_last_9_sends,dme.times_mailed_card_last_9_sends,dme.times_mailed_last_9_sends,dme.fico_score, dme.pl_response_400_score,dme.pl_default_520_score,dme.income_300_score,dme.cvtg03, dme.bpid,dme.bankruptcy_200_score
    from avant.prod.dw.dw_orig.direct_mail_prospect_selected_by_send as dme) as dme
    on dme.consumerid = dm.consumerid and dm.bpid = dme.bpid
    ) as dm inner join
    (select dm.creative_code,dm.group_description,dm.creative_description,DATE_PART('year',MIN(COALESCE(lca.created_time,cca.created_time))) AS Campaign_Year, DATE_PART('month',MIN(COALESCE(lca.created_time,cca.created_time))) AS Campaign_Month,date_trunc('day',MIN(COALESCE(lca.created_time,cca.created_time))) AS Campaign_Actual_Start,TO_DATE(dmcs.drop_date,'YYYY-MM-DD') AS Campaign_Estimated_Start,COALESCE(LAG (date_trunc('day',MIN(COALESCE(lca.created_time,cca.created_time))),1) OVER (ORDER BY dm.creative_code DESC),MAX(TO_DATE(dmcs.end_date,'YYYY-MM-DD'))) AS Campaign_End_Date ,MAX(TO_DATE(dmcs.end_date,'YYYY-MM-DD')) AS Campaign_Actual_End_Date,dm.product AS Product
    from avant.prod.dw.dw_orig.ad_hoc.direct_mail_creative_code as dm 
    left join avant.prod.dw.dw_orig.cc_account_customer_application as cca 
    on cca.creative_code = dm.creative_code
    left join avant.prod.dw.dw_orig.loan_customer_application as lca
    on lca.creative_code = dm.creative_code inner join
    avant.prod.dw.dw_orig.ad_hoc.dm_metadata_campaign_segments as dmcs
    on dmcs.coupon_code = dm.creative_code
    where dm.product = 'Loan' and lca.created_time >= dmcs.drop_date 
    group by 1,2,3,7,10
    ) as dmc on dmc.creative_code = dm.creative_type 
    LEFT JOIN
    avant.prod.intermediate.dw.dw_orig.loan_customer_application as lca 
    on (lca.personal_offer_code = dm.poc and lca.creative_code = dm.creative_type) 
    LEFT JOIN
    avant.prod.dw.dw_serv.loan on loan.loan_id = lca.loan_id left join
    (select lcd.credit_decline_reasons, lcd.product_decline_reasons, lcd.eligibility_decline_reasons,  lcd.risk_segment, lcd.product_rating, lcd.loan_customer_application_uuid,lcd.eligibility_approved_flag, lcd.credit_approved_flag, lcd.product_approved_flag
    from avant.prod.dw.dw_orig.loan_credit_decision as lcd inner join
    (select lcd.loan_customer_application_uuid, max(lcd.created_time) as created_time
    from avant.prod.dw.dw_orig.loan_credit_decision as lcd
    where DATE_PART('year',lcd.created_time) >= 2021
    group by 1) as l2 on l2.created_time = lcd.created_time and l2.loan_customer_application_uuid = lcd.loan_customer_application_uuid    ) as lcd on lcd.loan_customer_application_uuid = lca.loan_customer_application_uuid
    where dmc.Campaign_Year IS NOT NULL and dm.poc IS NOT NULL
