query 50004 Student
{
    QueryType = API;
    APIPublisher = 'appKings';
    APIVersion = 'v1.0';
    EntityName = 'student';
    EntitySetName = 'students';
    APIGroup = 'postgraduateApplication';

    elements
    {
        dataitem(customer; Customer)
        {
            DataItemTableFilter = "Customer Type" = const(Student);
            column(academicYear; "Academic Year")
            {
            }
            column(accountNo; "Account No")
            {
            }
            column(accreditedCentreNo; "Accredited Centre no.")
            {
            }
            column(address; Address)
            {
            }
            column(address2; "Address 2")
            {
            }
            column(admissionDate; "Admission Date")
            {
            }
            column(adults; Adults)
            {
            }
            column(age; Age)
            {
            }
            column(allowLineDisc; "Allow Line Disc.")
            {
            }
            column(allowMultiplePostingGroups; "Allow Multiple Posting Groups")
            {
            }
            column(allowRegWithBalance; "Allow Reg. With Balance")
            {
            }
            column(allowedDate; "Allowed Date")
            {
            }
            column(allowedRegBy; "Allowed Reg. By")
            {
            }
            column(amount; Amount)
            {
            }
            column(applicationMethod; "Application Method")
            {
            }
            column(applicationNo; "Application No.")
            {
            }
            column(appliedForClearance; "Applied for Clearance")
            {
            }
            column(arrivalDate; "Arrival Date")
            {
            }
            column(auditIssue; "Audit Issue")
            {
            }
            column(balance; Balance)
            {
            }
            column(balanceCafe; "Balance (Cafe)")
            {
            }
            column(balanceLCY; "Balance (LCY)")
            {
            }
            column(balanceDue; "Balance Due")
            {
            }
            column(balanceDueLCY; "Balance Due (LCY)")
            {
            }
            column(balanceOnDate; "Balance on Date")
            {
            }
            column(balanceOnDateLCY; "Balance on Date (LCY)")
            {
            }
            column(bankCode; "Bank Code")
            {
            }
            column(bankCommunication; "Bank Communication")
            {
            }
            column(barcodePicture; "Barcode Picture")
            {
            }
            column(baseCalendarCode; "Base Calendar Code")
            {
            }
            column(billToNoOfBlanketOrders; "Bill-To No. of Blanket Orders")
            {
            }
            column(billToNoOfCreditMemos; "Bill-To No. of Credit Memos")
            {
            }
            column(billToNoOfInvoices; "Bill-To No. of Invoices")
            {
            }
            column(billToNoOfOrders; "Bill-To No. of Orders")
            {
            }
            column(billToNoOfPstdCrMemos; "Bill-To No. of Pstd. Cr. Memos")
            {
            }
            column(billToNoOfPstdInvoices; "Bill-To No. of Pstd. Invoices")
            {
            }
            column(billToNoOfPstdReturnR; "Bill-To No. of Pstd. Return R.")
            {
            }
            column(billToNoOfPstdShipments; "Bill-To No. of Pstd. Shipments")
            {
            }
            column(billToNoOfQuotes; "Bill-To No. of Quotes")
            {
            }
            column(billToNoOfReturnOrders; "Bill-To No. of Return Orders")
            {
            }
            column(billToCustomerNo; "Bill-to Customer No.")
            {
            }
            column(billToNoOfArchivedDoc; "Bill-to No. Of Archived Doc.")
            {
            }
            column(birthCert; "Birth Cert")
            {
            }
            column(blackListedBy; "Black Listed By")
            {
            }
            column(blackListedReason; "Black Listed Reason")
            {
            }
            column(blockPaymentTolerance; "Block Payment Tolerance")
            {
            }
            column(blocked; Blocked)
            {
            }
            column(bloodGroup; "Blood Group")
            {
            }
            column(branchCode; "Branch Code")
            {
            }
            column(budgetedAmount; "Budgeted Amount")
            {
            }
            column(curpNo; "CURP No.")
            {
            }
            column(cafeBalance; "Cafe Balance")
            {
            }
            column(campusCode; "Campus Code")
            {
            }
            column(canUseLibrary; "Can Use Library")
            {
            }
            column(cashFlowPaymentTermsCode; "Cash Flow Payment Terms Code")
            {
            }
            column(cashier; Cashier)
            {
            }
            column(cateringAmount; "Catering Amount")
            {
            }
            column(certificateNo; "Certificate No.")
            {
            }
            column(certificateStatus; "Certificate Status")
            {
            }
            column(chainName; "Chain Name")
            {
            }
            column(changedPassword; "Changed Password")
            {
            }
            column(chargesAmount; "Charges Amount")
            {
            }
            column(checkDateFormat; "Check Date Format")
            {
            }
            column(checkDateSeparator; "Check Date Separator")
            {
            }
            column(checkInTime; "Check In Time")
            {
            }
            column(checkOutDate; "Check Out Date")
            {
            }
            column(checkedBy; "Checked By")
            {
            }
            column(childrenUnder12; "Children Under 12")
            {
            }
            column(citizenship; Citizenship)
            {
            }
            column(city; City)
            {
            }
            column(classCode; "Class Code")
            {
            }
            column(clearanceAcademicYear; "Clearance Academic Year")
            {
            }
            column(clearanceInitiatedDate; "Clearance Initiated Date")
            {
            }
            column(clearanceInitiatedTime; "Clearance Initiated Time")
            {
            }
            column(clearanceInitiatedBy; "Clearance Initiated by")
            {
            }
            column(clearanceReason; "Clearance Reason")
            {
            }
            column(clearanceSemester; "Clearance Semester")
            {
            }
            column(clearanceStatus; "Clearance Status")
            {
            }
            column(clubEngagementScore; "Club Engagement Score")
            {
            }
            column(collectionMethod; "Collection Method")
            {
            }
            column(combineShipments; "Combine Shipments")
            {
            }
            column(comment; Comment)
            {
            }
            column(compNo; "Comp No")
            {
            }
            column(confirmed; Confirmed)
            {
            }
            column(confirmedOk; "Confirmed Ok")
            {
            }
            column(confirmedRemarks; "Confirmed Remarks")
            {
            }
            column(contact; Contact)
            {
            }
            column(contactGraphId; "Contact Graph Id")
            {
            }
            column(contactID; "Contact ID")
            {
            }
            column(contactType; "Contact Type")
            {
            }
            column(contractGainLossAmount; "Contract Gain/Loss Amount")
            {
            }
            column(copySellToAddrToQteFrom; "Copy Sell-to Addr. to Qte From")
            {
            }
            column(counselingSessions; "Counseling Sessions")
            {
            }
            column(countings; Countings)
            {
            }
            column(countryRegionCode; "Country/Region Code")
            {
            }
            column(county; County)
            {
            }
            column(coupledToCRM; "Coupled to CRM")
            {
            }
            column(coupledToDataverse; "Coupled to Dataverse")
            {
            }
            column(courseDetails; "Course Details")
            {
            }
            column(courseDuration; "Course Duration")
            {
            }
            column(crMemoAmounts; "Cr. Memo Amounts")
            {
            }
            column(crMemoAmountsLCY; "Cr. Memo Amounts (LCY)")
            {
            }
            column(creditAmount; "Credit Amount")
            {
            }
            column(creditAmountCafe; "Credit Amount (Cafe)")
            {
            }
            column(creditAmountLCY; "Credit Amount (LCY)")
            {
            }
            column(creditLimitLCY; "Credit Limit (LCY)")
            {
            }
            column(cummFailedCourses; "Cumm. Failed Courses")
            {
            }
            column(currencyCode; "Currency Code")
            {
            }
            column(currencyId; "Currency Id")
            {
            }
            column(currentFaculty; "Current Faculty")
            {
            }
            column(currentProgram; "Current Program")
            {
            }
            column(currentProgramme; "Current Programme")
            {
            }
            column(currentSemester; "Current Semester")
            {
            }
            column(currentSettlementType; "Current Settlement Type")
            {
            }
            column(currentStage; "Current Stage")
            {
            }
            column(customerDiscGroup; "Customer Disc. Group")
            {
            }
            column(customerPostingGroup; "Customer Posting Group")
            {
            }
            column(customerPriceGroup; "Customer Price Group")
            {
            }
            column(customerType; "Customer Type")
            {
            }
            column(dateCollected; "Date Collected")
            {
            }
            column(dateIssued; "Date Issued")
            {
            }
            column(dateOfBirth; "Date Of Birth")
            {
            }
            column(dateRegistered; "Date Registered")
            {
            }
            column(dateReturned; "Date Returned")
            {
            }
            column(debitAmount; "Debit Amount")
            {
            }
            column(debitAmountCafe; "Debit Amount (Cafe)")
            {
            }
            column(debitAmountLCY; "Debit Amount (LCY)")
            {
            }
            column(deferementPeriod; "Deferement Period")
            {
            }
            column(departureDate; "Departure Date")
            {
            }
            column(deposit; Deposit)
            {
            }
            column(disabilityDescription; "Disability Description")
            {
            }
            column(disabilityStatus; "Disability Status")
            {
            }
            column(disableSearchByName; "Disable Search by Name")
            {
            }
            column(district; District)
            {
            }
            column(documentNoFilter; "Document No. Filter")
            {
            }
            column(documentSendingProfile; "Document Sending Profile")
            {
            }
            column(doubles; Doubles)
            {
            }
            column(eMail; "E-Mail")
            {
            }
            column(eoriNumber; "EORI Number")
            {
            }
            column(emailPassword; "Email Password")
            {
            }
            column(excludeFromPmtPractices; "Exclude from Pmt. Practices")
            {
            }
            column(faxNo; "Fax No.")
            {
            }
            column(finChargeMemoAmountsLCY; "Fin. Charge Memo Amounts (LCY)")
            {
            }
            column(finChargeTermsCode; "Fin. Charge Terms Code")
            {
            }
            column(financeChargeMemoAmounts; "Finance Charge Memo Amounts")
            {
            }
            column(firstName; "First Name")
            {
            }
            column(formatRegion; "Format Region")
            {
            }
            column(gln; GLN)
            {
            }
            column(genBusPostingGroup; "Gen. Bus. Posting Group")
            {
            }
            column(gender; Gender)
            {
            }
            column(globalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(globalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(gown1; "Gown 1")
            {
            }
            column(gown2; "Gown 2")
            {
            }
            column(gown3; "Gown 3")
            {
            }
            column(gownStatus; "Gown Status")
            {
            }
            column(graduatingAcademicYear; "Graduating Academic Year")
            {
            }
            column(graduationDate; "Graduation Date")
            {
            }
            column(groupCompany; "Group/Company")
            {
            }
            column(helbNo; "HELB No.")
            {
            }
            column(htlStatus; "HTL Status")
            {
            }
            column(height; Height)
            {
            }
            column(homePage; "Home Page")
            {
            }
            column(hostelAllocated; "Hostel Allocated")
            {
            }
            column(hostelBlackListed; "Hostel Black Listed")
            {
            }
            column(hostelNo; "Hostel No.")
            {
            }
            column(icPartnerCode; "IC Partner Code")
            {
            }
            column(idCardExpiryYear; "ID Card Expiry Year")
            {
            }
            column(idNo; "ID No")
            {
            }
            column(image; Image)
            {
            }
            column(inCurrentSem; "In Current Sem")
            {
            }
            column(inGraduation; "In Graduation")
            {
            }
            column(intakeCode; "Intake Code")
            {
            }
            column(internalExternal; "Internal/External")
            {
            }
            column(intrastatPartnerType; "Intrastat Partner Type")
            {
            }
            column(invAmountsLCY; "Inv. Amounts (LCY)")
            {
            }
            column(invDiscountsLCY; "Inv. Discounts (LCY)")
            {
            }
            column(invoiceAmounts; "Invoice Amounts")
            {
            }
            column(invoiceCopies; "Invoice Copies")
            {
            }
            column(invoiceDiscCode; "Invoice Disc. Code")
            {
            }
            column(knecNo; "KNEC No")
            {
            }
            column(languageCode; "Language Code")
            {
            }
            column(lastDateModified; "Last Date Modified")
            {
            }
            column(lastEngagementDate; "Last Engagement Date")
            {
            }
            column(lastModifiedDateTime; "Last Modified Date Time")
            {
            }
            column(lastName; "Last Name")
            {
            }
            column(lastStatementNo; "Last Statement No.")
            {
            }
            column(leaveUsage; "Leave Usage")
            {
            }
            column(libMembership; "Lib Membership")
            {
            }
            column(libraryBranch; "Library Branch")
            {
            }
            column(libraryCategory; "Library Category")
            {
            }
            column(libraryCode; "Library Code")
            {
            }
            column(libraryExpiryDate; "Library Expiry Date")
            {
            }
            column(libraryGender; "Library Gender")
            {
            }
            column(libraryMembership; "Library Membership")
            {
            }
            column(librarySecurity; "Library Security")
            {
            }
            column(libraryUsername; "Library Username")
            {
            }
            column(locationCode; "Location Code")
            {
            }
            column(lockOnlineApplication; "Lock Online Application")
            {
            }
            column(maritalStatus; "Marital Status")
            {
            }
            column(membershipNo; "Membership No")
            {
            }
            column(middleName; "Middle Name")
            {
            }
            column(mobilePhoneNo; "Mobile Phone No.")
            {
            }
            column(name; Name)
            {
            }
            column(name2; "Name 2")
            {
            }
            column(name3; "Name 3")
            {
            }
            column(nationality; Nationality)
            {
            }
            column(netChange; "Net Change")
            {
            }
            column(netChangeLCY; "Net Change (LCY)")
            {
            }
            column(newStud; "New Stud")
            {
            }
            column(noOfCharges; "No Of Charges")
            {
            }
            column(noOfCreidts; "No Of Creidts")
            {
            }
            column(noOfReversals; "No Of Reversals")
            {
            }
            column(no; "No.")
            {
            }
            column(noOfReceipts; "No. Of Receipts")
            {
            }
            column(noOfReg; "No. Of Reg")
            {
            }
            column(noSeries; "No. Series")
            {
            }
            column(noOfBlanketOrders; "No. of Blanket Orders")
            {
            }
            column(noOfCreditMemos; "No. of Credit Memos")
            {
            }
            column(noOfInvoices; "No. of Invoices")
            {
            }
            column(noOfOrders; "No. of Orders")
            {
            }
            column(noOfPstdCreditMemos; "No. of Pstd. Credit Memos")
            {
            }
            column(noOfPstdInvoices; "No. of Pstd. Invoices")
            {
            }
            column(noOfPstdReturnReceipts; "No. of Pstd. Return Receipts")
            {
            }
            column(noOfPstdShipments; "No. of Pstd. Shipments")
            {
            }
            column(noOfQuotes; "No. of Quotes")
            {
            }
            column(noOfReturnOrders; "No. of Return Orders")
            {
            }
            column(noOfShipToAddresses; "No. of Ship-to Addresses")
            {
            }
            column(notBilled; "Not Billed")
            {
            }
            column(oldStatus; "Old Status")
            {
            }
            column(oldStudentCode; "Old Student Code")
            {
            }
            column(otherAmounts; "Other Amounts")
            {
            }
            column(otherAmountsLCY; "Other Amounts (LCY)")
            {
            }
            column(ourAccountNo; "Our Account No.")
            {
            }
            column(outstandingInvoices; "Outstanding Invoices")
            {
            }
            column(outstandingInvoicesLCY; "Outstanding Invoices (LCY)")
            {
            }
            column(outstandingOrders; "Outstanding Orders")
            {
            }
            column(outstandingOrdersLCY; "Outstanding Orders (LCY)")
            {
            }
            column(outstandingServOrdersLCY; "Outstanding Serv. Orders (LCY)")
            {
            }
            column(outstandingServInvoicesLCY; "Outstanding Serv.Invoices(LCY)")
            {
            }
            column(pinNo; "PIN No")
            {
            }
            column(paidPartTime; "Paid PartTime")
            {
            }
            column(partnerType; "Partner Type")
            {
            }
            column(passportNo; "Passport No")
            {
            }
            column(password; Password)
            {
            }
            column(paymentDate; "Payment Date")
            {
            }
            column(paymentMethodCode; "Payment Method Code")
            {
            }
            column(paymentMethodId; "Payment Method Id")
            {
            }
            column(paymentTermsCode; "Payment Terms Code")
            {
            }
            column(paymentTermsId; "Payment Terms Id")
            {
            }
            column(payments; Payments)
            {
            }
            column(paymentsLCY; "Payments (LCY)")
            {
            }
            column(paymentsBy; "Payments By")
            {
            }
            column(phoneNo; "Phone No.")
            {
            }
            column(placeOfExport; "Place of Export")
            {
            }
            column(pmtDiscToleranceLCY; "Pmt. Disc. Tolerance (LCY)")
            {
            }
            column(pmtDiscountsLCY; "Pmt. Discounts (LCY)")
            {
            }
            column(pmtToleranceLCY; "Pmt. Tolerance (LCY)")
            {
            }
            column(postCode; "Post Code")
            {
            }
            column(preferredBankAccountCode; "Preferred Bank Account Code")
            {
            }
            column(prepayment; "Prepayment %")
            {
            }
            column(priceCalculationMethod; "Price Calculation Method")
            {
            }
            column(pricesIncludingVAT; "Prices Including VAT")
            {
            }
            column(primaryContactNo; "Primary Contact No.")
            {
            }
            column(printStatements; "Print Statements")
            {
            }
            column(priority; Priority)
            {
            }
            column(privacyBlocked; "Privacy Blocked")
            {
            }
            column(profitLCY; "Profit (LCY)")
            {
            }
            column(programme; Programme)
            {
            }
            column(programmeCategory; "Programme Category")
            {
            }
            column(programmeEndDate; "Programme End Date")
            {
            }
            column(rfcNo; "RFC No.")
            {
            }
            column(rate; Rate)
            {
            }
            column(receiptNo; "Receipt No")
            {
            }
            column(refundOnPV; "Refund on PV")
            {
            }
            column(refunds; Refunds)
            {
            }
            column(refundsLCY; "Refunds (LCY)")
            {
            }
            column(registarCleared; "Registar Cleared")
            {
            }
            column(registeredFullTime; "Registered FullTime")
            {
            }
            column(registeredPartTime; "Registered PartTime")
            {
            }
            column(registrationNumber; "Registration Number")
            {
            }
            column(religion; Religion)
            {
            }
            column(remarks; Remarks)
            {
            }
            column(reminderAmounts; "Reminder Amounts")
            {
            }
            column(reminderAmountsLCY; "Reminder Amounts (LCY)")
            {
            }
            column(reminderTermsCode; "Reminder Terms Code")
            {
            }
            column(reserve; Reserve)
            {
            }
            column(responsibilityCenter; "Responsibility Center")
            {
            }
            column(revenueCashAccount; "Revenue Cash Account")
            {
            }
            column(roomCode; "Room Code")
            {
            }
            column(roomType; "Room Type")
            {
            }
            column(roomNo; "Room no")
            {
            }
            column(salesLCY; "Sales (LCY)")
            {
            }
            column(salespersonCode; "Salesperson Code")
            {
            }
            column(school; School)
            {
            }
            column(searchName; "Search Name")
            {
            }
            column(sellToNoOfArchivedDoc; "Sell-to No. Of Archived Doc.")
            {
            }
            column(semester; Semester)
            {
            }
            column(semesterFilter; "Semester Filter")
            {
            }
            column(senateClassificationBasedOn; "Senate Classification Based on")
            {
            }
            column(servShippedNotInvoicedLCY; "Serv Shipped Not Invoiced(LCY)")
            {
            }
            column(serviceZoneCode; "Service Zone Code")
            {
            }
            column(settlementType; "Settlement Type")
            {
            }
            column(shipToCode; "Ship-to Code")
            {
            }
            column(shipmentMethodCode; "Shipment Method Code")
            {
            }
            column(shipmentMethodId; "Shipment Method Id")
            {
            }
            column(shippedNotInvoiced; "Shipped Not Invoiced")
            {
            }
            column(shippedNotInvoicedLCY; "Shipped Not Invoiced (LCY)")
            {
            }
            column(shippingAdvice; "Shipping Advice")
            {
            }
            column(shippingAgentCode; "Shipping Agent Code")
            {
            }
            column(shippingAgentServiceCode; "Shipping Agent Service Code")
            {
            }
            column(shippingTime; "Shipping Time")
            {
            }
            column(singles; Singles)
            {
            }
            column(spaceBooked; "Space Booked")
            {
            }
            column(specialRequrements; "Special Requrements")
            {
            }
            column(sponsorAddress; "Sponsor Address")
            {
            }
            column(sponsorName; "Sponsor Name")
            {
            }
            column(sponsorPhone; "Sponsor Phone")
            {
            }
            column(sponsorTown; "Sponsor Town")
            {
            }
            column(spouceName; "Spouce Name")
            {
            }
            column(spouseId; "Spouse Id")
            {
            }
            column(spousePhone; "Spouse Phone")
            {
            }
            column(staffNo; "Staff No.")
            {
            }
            column(stateInscription; "State Inscription")
            {
            }
            column(statisticsGroup; "Statistics Group")
            {
            }
            column(status; Status)
            {
            }
            column(statusChangeDate; "Status Change Date")
            {
            }
            column(studentBalance; "Student Balance")
            {
            }
            column(studentProgramme; "Student Programme")
            {
            }
            column(student_Type; "Student Type")
            {
            }
            column(studyMode; "Study Mode")
            {
            }
            column(supervisorName; "Supervisor Name")
            {
            }
            column(supervisorNo; "Supervisor No.")
            {
            }
            column(systemCreatedAt; SystemCreatedAt)
            {
            }
            column(systemCreatedBy; SystemCreatedBy)
            {
            }
            column(systemId; SystemId)
            {
            }
            column(systemModifiedAt; SystemModifiedAt)
            {
            }
            column(systemModifiedBy; SystemModifiedBy)
            {
            }
            column(taggedAsGraduating; "Tagged as Graduating")
            {
            }
            column(takenBy; "Taken By")
            {
            }
            column(taxAreaCode; "Tax Area Code")
            {
            }
            column(taxAreaID; "Tax Area ID")
            {
            }
            column(taxExemptionNo; "Tax Exemption No.")
            {
            }
            column(taxIdentificationType; "Tax Identification Type")
            {
            }
            column(taxLiable; "Tax Liable")
            {
            }
            column(telexAnswerBack; "Telex Answer Back")
            {
            }
            column(telexNo; "Telex No.")
            {
            }
            column(territoryCode; "Territory Code")
            {
            }
            column(totalBilled; "Total Billed")
            {
            }
            column(totalDonations; "Total Donations")
            {
            }
            column(totalPaid; "Total Paid")
            {
            }
            column(totalRegistered; "Total Registered")
            {
            }
            column(transferTo; "Transfer to")
            {
            }
            column(transferToNo; "Transfer to No.")
            {
            }
            column(tribe; Tribe)
            {
            }
            column(triples; Triples)
            {
            }
            column(unisaNo; "UNISA No")
            {
            }
            column(upsZone; "UPS Zone")
            {
            }
            column(unbilledCharged; "Unbilled Charged")
            {
            }
            column(universityEmail; "University Email")
            {
            }
            column(updatedProfile; "Updated Profile")
            {
            }
            column(useGLNInElectronicDocument; "Use GLN in Electronic Document")
            {
            }
            column(userID; "User ID")
            {
            }
            column(vatBusPostingGroup; "VAT Bus. Posting Group")
            {
            }
            column(vatRegistrationNo; "VAT Registration No.")
            {
            }
            column(validateEUVatRegNo; "Validate EU Vat Reg. No.")
            {
            }
            column(vehicleNo; "Vehicle No.")
            {
            }
            column(weight; Weight)
            {
            }
            column(libsecurity; libsecurity)
            {
            }
            column(smsPassword; sms_Password)
            {
            }
            column(studentType; studentType)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
