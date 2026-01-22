table 50044 "PEN-Claims"
{
    Caption = 'PEN-Claims';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "PF No."; Code[20])
        {
            Caption = 'PF No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            DataClassification = ToBeClassified;
        }
        field(4; Name; Text[150])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(5; "Category Code"; Code[10])
        {
            Caption = 'Category Code';
            DataClassification = ToBeClassified;
        }
        field(6; "Category "; Text[100])
        {
            Caption = 'Category ';
            DataClassification = ToBeClassified;
        }
        field(7; "Date Employed"; Date)
        {
            Caption = 'Date Employed';
            DataClassification = ToBeClassified;
        }
        field(8; Gender; Option)
        {
            Caption = 'Gender';
            DataClassification = ToBeClassified;
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(9; "Dept Code"; Code[20])
        {
            Caption = 'Dept Code';
            DataClassification = ToBeClassified;
        }
        field(10; Department; Text[100])
        {
            Caption = 'Department';
            DataClassification = ToBeClassified;
        }
        field(11; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            DataClassification = ToBeClassified;
        }
        field(12; "Years of Pens. Service"; Decimal)
        {
            Caption = 'Years of Pens. Service';
            DataClassification = ToBeClassified;
        }
        field(13; "Date of Exit"; Date)
        {
            Caption = 'Date of Exit';
            DataClassification = ToBeClassified;
        }
        field(14; Age; Decimal)
        {
            Caption = 'Age';
            DataClassification = ToBeClassified;
        }
        field(15; "Date of Calculation"; Date)
        {
            Caption = 'Date of Calculation';
            DataClassification = ToBeClassified;
        }
        field(16; "EE CC Tax Exempt"; Decimal)
        {
            Caption = 'EE CC Tax Exempt';
            DataClassification = ToBeClassified;
        }
        field(17; "ER CC Tax Exempt"; Decimal)
        {
            Caption = 'ER CC Tax Exempt';
            DataClassification = ToBeClassified;
        }
        field(18; "AVC Tax Exempt"; Decimal)
        {
            Caption = 'AVC Tax Exempt';
            DataClassification = ToBeClassified;
        }
        field(19; "Interest Tax Exempt"; Decimal)
        {
            Caption = 'Interest Tax Exempt';
            DataClassification = ToBeClassified;
        }
        field(20; "EE CC Non Tax Exempt"; Decimal)
        {
            Caption = 'EE CC Non Tax Exempt';
            DataClassification = ToBeClassified;
        }
        field(21; "ER CC Non Tax Exempt"; Decimal)
        {
            Caption = 'ER CC Non Tax Exempt';
            DataClassification = ToBeClassified;
        }
        field(22; "AVC Non Tax Exempt"; Decimal)
        {
            Caption = 'AVC Non Tax Exempt';
            DataClassification = ToBeClassified;
        }
        field(23; "Interest Non Tax Exempt"; Decimal)
        {
            Caption = 'Interest Non Tax Exempt';
            DataClassification = ToBeClassified;
        }
        field(24; "Total Balance"; Decimal)
        {
            Caption = 'Total Balance';
            DataClassification = ToBeClassified;
        }
        field(25; "Claim Type Code"; Code[10])
        {
            Caption = 'Claim Type Code';
            DataClassification = ToBeClassified;
        }
        field(26; "Claim Type "; Text[50])
        {
            Caption = 'Claim Type ';
            DataClassification = ToBeClassified;
        }
        field(27; "Type"; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Retirement,Last Expense,Member Claim,Death Benefits';
            OptionMembers = Retirement,"Last Expense","Member Claim","Death Benefits";
        }
        field(28; "Eligible Amount"; Decimal)
        {
            Caption = 'Eligible Amount';
            DataClassification = ToBeClassified;
        }
        field(29; "Lumpsum Option"; Option)
        {
            Caption = 'Lumpsum Option';
            DataClassification = ToBeClassified;
            OptionCaption = 'No Lumpsum,Minimum Lumpsum,Maximum Lumpsum,Flexi';
            OptionMembers = "No Lumpsum","Minimum Lumpsum","Maximum Lumpsum",Flexi;
        }
        field(30; "Lumpsum Amount"; Decimal)
        {
            Caption = 'Lumpsum Amount';
            DataClassification = ToBeClassified;
        }
        field(31; "Annuity Premium/Income DD Amt"; Decimal)
        {
            Caption = 'Annuity Premium / Income Drawdown Amount';
            DataClassification = ToBeClassified;
        }
        field(32; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Released,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(33; "Paid-Lumpsum"; Boolean)
        {
            Caption = 'Lumpsum Paid';
            DataClassification = ToBeClassified;
        }
        field(34; "Application Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Computation,Finance,Instruction Sent to Custodian,Paid,Returned,Rejected';
            OptionMembers = Computation,Finance,"Instruction Sent to Custodian",Paid,Returned,Rejected;
        }
        field(35; Select; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Selected By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "KRA PIN"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Total Tax Exempt Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Total Non Tax Exempt Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Tax Exempt Lumpsum Amount"; Decimal)
        {
            Caption = 'Tax Exempt Lumpsum Amount';
            DataClassification = ToBeClassified;
        }
        field(41; "Tax Exempt Annuity/Income DD"; Decimal)
        {
            Caption = 'Tax Exempt Annuity Premium / Income Drawdown Amount';
            DataClassification = ToBeClassified;
        }
        field(42; "Non Tax Exempt Lumpsum Amount"; Decimal)
        {
            Caption = 'Non Tax Exempt Lumpsum Amount';
            DataClassification = ToBeClassified;
        }
        field(43; "Non Tax Exempt Annuity/Inc. DD"; Decimal)
        {
            Caption = 'Non Tax Exempt Annuity Premium / Income Drawdown Amount';
            DataClassification = ToBeClassified;
        }
        field(44; "Lumpsum Amount Payable"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Tax Free Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Taxable Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Total Tax Payable"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Total Accumulated Benefits"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Gross Lumpsum Payable"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Net Amount Payable"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Total Annuity/Income DD"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Reason Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(53; Reason; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(54; "AVC Withdrawal Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(55; "AVC Option"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Same as Lumpsum Option,No Withdrawal,100% Drawdown/Annuity,100% Lumpsum,Flexi';
            OptionMembers = "Same as Lumpsum Option","No Withdrawal","100% Drawdown/Annuity","100% Lumpsum","Flexi";
        }
        field(56; "AVC Lumpsum"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(57; "AVC Income DD/Annuity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        //Final Lumpsum Withdrawals to be debited to Client Ledger
        field(58; "EE CC Tax Exempt-Lumpsum"; Decimal)
        {
            Caption = 'EE CC Tax Exempt-Lumpsum';
            DataClassification = ToBeClassified;
        }
        field(59; "ER CC Tax Exempt-Lumpsum"; Decimal)
        {
            Caption = 'ER CC Tax Exempt-Lumpsum';
            DataClassification = ToBeClassified;
        }
        field(60; "AVC Tax Exempt-Lumpsum"; Decimal)
        {
            Caption = 'AVC Tax Exempt-Lumpsum';
            DataClassification = ToBeClassified;
        }
        field(61; "Interest Tax Exempt-Lumpsum"; Decimal)
        {
            Caption = 'Interest Tax Exempt-Lumpsum';
            DataClassification = ToBeClassified;
        }
        field(62; "EE CC NonTax Exempt-Lumpsum"; Decimal)
        {
            Caption = 'EE CC Non Tax Exempt-Lumpsum';
            DataClassification = ToBeClassified;
        }
        field(63; "ER CC NonTax Exempt-Lumpsum"; Decimal)
        {
            Caption = 'ER CC Non Tax Exempt-Lumpsum';
            DataClassification = ToBeClassified;
        }
        field(64; "AVC Non Tax Exempt-Lumpsum"; Decimal)
        {
            Caption = 'AVC Non Tax Exempt-Lumpsum';
            DataClassification = ToBeClassified;
        }
        field(65; "Int. NonTax Exempt-Lumpsum"; Decimal)
        {
            Caption = 'Interest Non Tax Exempt-Lumpsum';
            DataClassification = ToBeClassified;
        }
        //Final Income DD/Annuity Withdrawals to be debited to Client Ledger
        field(66; "EE CC Tax Exempt-DD/Annuity"; Decimal)
        {
            Caption = 'EE CC Tax Exempt-DD/Annuity';
            DataClassification = ToBeClassified;
        }
        field(67; "ER CC Tax Exempt-DD/Annuity"; Decimal)
        {
            Caption = 'ER CC Tax Exempt-DD/Annuity';
            DataClassification = ToBeClassified;
        }
        field(68; "AVC Tax Exempt-DD/Annuity"; Decimal)
        {
            Caption = 'AVC Tax Exempt-DD/Annuity';
            DataClassification = ToBeClassified;
        }
        field(69; "Interest Tax Exempt-DD/Annuity"; Decimal)
        {
            Caption = 'Interest Tax Exempt-DD/Annuity';
            DataClassification = ToBeClassified;
        }
        field(70; "EE CC NonTax Exempt-DD/Annuity"; Decimal)
        {
            Caption = 'EE CC Non Tax Exempt-DD/Annuity';
            DataClassification = ToBeClassified;
        }
        field(71; "ER CC NonTax Exempt-DD/Annuity"; Decimal)
        {
            Caption = 'ER CC Non Tax Exempt-DD/Annuity';
            DataClassification = ToBeClassified;
        }
        field(72; "AVC Non Tax Exempt-DD/Annuity"; Decimal)
        {
            Caption = 'AVC Non Tax Exempt-DD/Annuity';
            DataClassification = ToBeClassified;
        }
        field(73; "Int. NonTax Exempt-DD/Annuity"; Decimal)
        {
            Caption = 'Interest Non Tax Exempt-DD/Annuity';
            DataClassification = ToBeClassified;
        }
        field(74; "AVC Tax Exempt-Withdrawal"; Decimal)
        {
            Caption = 'AVC Tax Exempt-Withdrawal';
            DataClassification = ToBeClassified;
        }
        field(75; "AVC Non Tax Exempt-Withdrawal"; Decimal)
        {
            Caption = 'AVC Non Tax Exempt-Withdrawal';
            DataClassification = ToBeClassified;
        }
        field(76; "Header No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(77; "Withdrawn-Lumpsum"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(78; "Withdrawn-DD/Annuity"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(79; "Paid-DD/Annuity"; Boolean)
        {
            Caption = 'Annuity/Drawdown Paid';
            DataClassification = ToBeClassified;
        }
        field(80; "Computation Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Initial,Revision';
            OptionMembers = Initial,Revision;
        }
        field(81; "Old Claim No."; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(82; "Lumpsum Amount Earlier"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(83; "Income DD/Annuity Earlier"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(84; "Tax Paid Earlier"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(85; "Reserve Payable on Open Bal."; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Reserve Payable on Opening Balance';
        }
        field(86; "No of Months"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(87; "EE Earlier Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(88; "ER Earlier Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(89; "EE Tax Exempt Earlier Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(90; "ER Tax Exempt Earlier Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(91; "EE Non Tax Exempt Earlier Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(92; "ER Non Tax Exempt Earlier Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(93; "EE TE Earlier Paid-Lumpsum"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(94; "EE TE Earlier Paid-DD/Annuity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(95; "EE NTE Earlier Paid-Lumpsum"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(96; "EE NTE Earlier Paid-DD/Annuity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(97; "ER TE Earlier Paid-Lumpsum"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(98; "ER TE Earlier Paid-DD/Annuity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(99; "ER NTE Earlier Paid-Lumpsum"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(100; "ER NTE Earlier Paid-DD/Annuity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(101; "Reserve - Tax Exempt"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(102; "Reserve - NonTax Exempt"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(103; "Open Balance - Tax Exempt"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(104; "Open Balance - Non Tax Exempt"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(105; "Revised Total Tax Payable"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(106; "Revised EE Payable"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(107; "Revised ER Payable"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(108; "Revised Total Amount Payable"; Decimal)//Total amt. payable(before tax):
        {
            DataClassification = ToBeClassified;
        }
        field(109; "Revised Tot. Tax Payable"; Decimal)//TT Tax Payable(exempt):
        {
            DataClassification = ToBeClassified;
        }
        field(110; "Revised Net Amount Payable"; Decimal)//Amt. payable(after tax):
        {
            DataClassification = ToBeClassified;
        }
        field(111; "ER Amount Retained"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(112; "Selected Lumpsum Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(113; "Selected DD/Annuity Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Selected Income Drawdown/Annuity Amount';
        }
        field(114; "Revised Annuity/Income DD"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(115; "Open Balance - EE TE"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(116; "Open Balance - EE NTE"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(117; "Open Balance - ER TE"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(118; "Open Balance - ER NTE"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(119; "Open Balance - AVC TE"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(120; "Open Balance - AVC NTE"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(121; "Reserve - EE TE"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(122; "Reserve - EE NTE"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(123; "Reserve - ER TE"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(124; "Reserve - ER NTE"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(125; "Sponsor Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50000; "Members Fund Vendor A/c"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Lumpsum Payment Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Annuity/Income DD Payment Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Annuity Purch. Expense Ac"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Accrual for Annuity Purch. Ac"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Lumpsum Expense Ac"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; Accrued; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "PV No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
