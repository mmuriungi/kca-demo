table 54252 "Casual Payment Lines."
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Editable = false;
            TableRelation = "Casual Payment Header."."No.";
        }
        field(2; "Line No."; Integer)
        {
            Editable = false;
        }
        field(4; "Account Type"; Option)
        {
            Caption = 'Account Type';
            InitValue = Vendor;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(5; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor;
        }
        field(6; Description; Text[50])
        {
            Editable = true;
        }
        field(7; "Cheque No."; Code[20])
        {
        }
        field(8; "Posting Date"; Date)
        {
        }
        field(50008; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            InitValue = New;
            OptionCaption = 'New,Approval Pending,Transfer Budget Pending,Approved,Disapproved,Committed,,,,,Fulfilled,Canceled';
            OptionMembers = New,"Approval Pending","Transfer Budget Pending",Approved,Disapproved,Committed,,,,,Fulfilled,Canceled;
        }
        field(50010; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
            end;
        }
        field(50011; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(50012; "Basic Amount"; Decimal)
        {
        }
        field(50013; "PAYE Amount"; Decimal)
        {
        }
        field(50014; "NSSF Amount"; Decimal)
        {
        }
        field(50015; "NHIF Amount"; Decimal)
        {
        }
        field(50016; "Employee No"; Code[10])
        {
            TableRelation = "Casual Employees."."Casual No";

            trigger OnValidate()
            begin
                Empob.RESET;
                Empob.SETRANGE(Empob."Casual No", "Employee No");
                IF Empob.FIND('-') THEN BEGIN
                    "Employee Name" := Empob."Full  Name";
                    "Bank Code" := Empob."Bank Code";
                    "Bank Name" := Empob."Bank Name";
                    "Bank Account No" := Empob."Bank Account Number";
                    Occupation := Empob."Task Code";
                    "Rate per Date" := Empob."Rate per Day";
                    "Rate per Month" := Empob."Rate Per Month";
                    "No of Days" := Empob."No of Days value";
                    "Shortcut Dimension 1 Code" := Empob."Revenue Division";
                    "Shortcut Dimension 2 Code" := Empob.Department;
                END;
            end;
        }
        field(50017; "Employee Name"; Text[50])
        {
        }
        field(50018; "Bank Code"; Code[50])
        {
        }
        field(50019; "Bank Name"; Text[50])
        {
        }
        field(50020; "Bank Account No"; Code[30])
        {
        }
        field(50050; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnLookup()
            begin
                //ShowDocDim;
            end;
        }
        field(50051; "Rate per Month"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50052; "No of Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50053; "Total Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "Pay Stutatories"; Option)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;

            trigger OnValidate()
            begin
                IF "Pay Stutatories" = "Pay Stutatories"::Yes THEN BEGIN
                    // PAYE
                    prPAYE.RESET;
                    IF prPAYE.FINDFIRST THEN BEGIN
                        IF "Basic Amount" < prPAYE."PAYE Tier" THEN EXIT;
                                                 REPEAT
                                                     KeepCount += 1;
                                                     curTempAmount := "Basic Amount";
                                                     IF "Basic Amount" = 0 THEN EXIT;

                                                     IF "Basic Amount" >= prPAYE."PAYE Tier" THEN BEGIN
                                                         curTempAmount := prPAYE."PAYE Tier";

                                                         curTempAmount := curTempAmount - 200;

                                                         PAYE := PAYE + (curTempAmount * (prPAYE.Rate / 100));
                                                     END;
                                                     "PAYE Amount" := PAYE - 1408;
                                                 UNTIL prPAYE.NEXT = 0;
                        "Net Pay" := "Basic Amount" - PAYE;
                        MESSAGE('payeamount%1,Netpayamount%2', (prPAYE.Rate / 100), "Net Pay");
                    END;
                    //NSSF//
                    NSSReliefSetUp.GET;
                    "NSSF Amount" := NSSReliefSetUp.Earnings;
                    "Net Pay" := "Net Pay" - "NSSF Amount";
                    //NHIF
                    prNHIF.RESET;
                    prNHIF.SETCURRENTKEY(prNHIF."Tier Code");
                    IF prNHIF.FINDFIRST THEN BEGIN
                                                 REPEAT
                                                     IF (("Basic Amount" >= prNHIF."Lower Limit") AND ("Basic Amount" <= prNHIF."Upper Limit")) THEN
                                                         NHIF := prNHIF.Amount;
                                                     "NHIF Amount" := NHIF;
                                                 UNTIL prNHIF.NEXT = 0;
                        "Net Pay" := "Net Pay" - "NHIF Amount";
                    END;
                END ELSE
                    IF "Pay Stutatories" = "Pay Stutatories"::No THEN
                        "Net Pay" := "Basic Amount";
                "PAYE Amount" := 0;
                "NSSF Amount" := 0;
                "NHIF Amount" := 0;
                //get net pay
            end;
        }
        field(50055; Occupation; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50056; "Rate per Date"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50057; "Pay Rate"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',per Day,Per Month';
            OptionMembers = ,"per Day","Per Month";
        }
        field(50058; "Period (Month)"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "Net Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50060; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.", "Employee No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        GLSetupRead: Boolean;
        CurrencyCode: Code[10];
        Currency: Record 4;
        GLSetup: Record 98;
        CurrExchRate: Record 330;
        //CashMgtSetup: Record 55497;
        NoSeriesMgt: Codeunit 396;
        BankAccount: Record 270;
        Vendor: Record 23;
        UsetSetup: Record 91;
        PaymentLine: Record "Casual Payment Lines.";
        Test: Code[20];
        DimMgt: Codeunit 408;
        //FundsTaxCodes: Record 5486;
        Err10000: Label 'VAT can only be specified for GL Expense entries only';
        Text002: Label 'cannot be specified without %1';
        Text064: Label 'You may have changed a dimension.\\Do you want to update the lines?';
        Text5000: Label 'Payment lines that cannot be deleted.  This line has already been processed';
        Empob: Record "Casual Employees.";
        CasualObject: Record "Confirmation of Work";
        Noofdays: Integer;
        prPAYE: Record "PRL-PAYE";
        curTempAmount: Decimal;
        KeepCount: Integer;
        PAYE: Decimal;
        NSSReliefSetUp: Record "prNSSF Tiers";
        prNHIF: Record "PRL-NHIF";
        NHIF: Decimal;
        ReliefAmount: Decimal;

    procedure DeleteEncumCommitLines()
    begin
    end;
}

