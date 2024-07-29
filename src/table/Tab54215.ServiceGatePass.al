table 54215 "Service Gate Pass"
{

    fields
    {
        field(1; "Gate Pass No."; Code[20])
        {

            trigger OnValidate()
            begin
                IF "Gate Pass No." <> xRec."Gate Pass No." THEN BEGIN
                    ServiceSetup.GET;
                    NoSeriesMgt.TestManual(ServiceSetup."Service Invoice Nos.");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; Date; Date)
        {
        }
        field(3; "Time Out"; Time)
        {
        }
        field(4; "Job/Service No."; Code[20])
        {
            TableRelation = "Service Item Line"."Document No." WHERE("Repair Status Code" = FILTER('FINISHED'));

            trigger OnValidate()
            begin
                /*
                ServiceItemLine.RESET;
                ServiceItemLine.SETRANGE(ServiceItemLine."Document No.","Job/Service No.");
                IF ServiceItemLine.FIND('-') THEN BEGIN
                
                  "Registration No." := ServiceItemLine."Registration No.";
                  "Chassis No." := ServiceItemLine."Chassis No.";
                  "Gear Box Code" := ServiceItemLine."Gear Box Code";
                  "Engine Code" := ServiceItemLine."Engine Code";
                  "Customer No." := ServiceItemLine."Customer No.";
                
                   Customer.RESET;
                   IF Customer.GET("Customer No.") THEN "Customer Name" := Customer.Name;
                
                END ELSE BEGIN
                
                  "Registration No." := ' ';
                  "Chassis No." := ' ';
                  "Gear Box Code" := ' ';
                  "Engine Code" := ' ';
                  "Customer No." := ' ';
                  "Customer Name" := ' ';
                
                END;
                */

            end;
        }
        field(5; "Registration No."; Text[30])
        {
        }
        field(6; "Chassis No."; Text[30])
        {
        }
        field(7; "Gear Box Code"; Text[30])
        {
        }
        field(8; "Engine Code"; Text[30])
        {
        }
        field(9; "Customer No."; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(10; "Customer Name"; Text[50])
        {
        }
        field(11; "Driver Name"; Text[50])
        {
        }
        field(12; "Invoice No."; Code[20])
        {

            trigger OnLookup()
            begin

                // CustLedgEntry.RESET;
                // CustLedgEntry.SETCURRENTKEY("Customer No.",Open,Positive,"Due Date");
                // CustLedgEntry.SETRANGE(CustLedgEntry."Customer No.","Customer No.");
                // CustLedgEntry.SETRANGE(CustLedgEntry."Document Type",CustLedgEntry."Document Type"::Invoice);

                // SelectCustEntries.SETTABLEVIEW(CustLedgEntry);
                // SelectCustEntries.SETRECORD(CustLedgEntry);
                // SelectCustEntries.LOOKUPMODE(TRUE);
                // IF SelectCustEntries.RUNMODAL = ACTION::LookupOK THEN BEGIN
                //   "Invoice No." := SelectCustEntries.GetCustLedgEntry(CustLedgEntry);
                // END;
                // CLEAR(SelectCustEntries);


            end;
        }
        field(13; "Receipt No."; Code[20])
        {
            TableRelation = "Cust. Ledger Entry"."Document No." WHERE("Customer No." = FIELD("Customer No."),
                                                                       "Source Code" = FILTER('CASHRECJNL'));

            trigger OnLookup()
            begin

                CustLedgEntry.RESET;
                CustLedgEntry.SETCURRENTKEY("Customer No.", Open, Positive, "Due Date");
                CustLedgEntry.SETRANGE(CustLedgEntry."Customer No.", "Customer No.");
                CustLedgEntry.SETRANGE(CustLedgEntry."Document Type", CustLedgEntry."Document Type"::Payment);

                // SelectCustEntries.SETTABLEVIEW(CustLedgEntry);
                // SelectCustEntries.SETRECORD(CustLedgEntry);
                // SelectCustEntries.LOOKUPMODE(TRUE);
                // SelectCustEntries.EDITABLE:=FALSE;
                // IF SelectCustEntries.RUNMODAL = ACTION::LookupOK THEN BEGIN
                //   "Receipt No." := SelectCustEntries.GetCustLedgEntry(CustLedgEntry);
                // END;
                // CLEAR(SelectCustEntries);


            end;
        }
        field(14; "Admit Code"; Text[30])
        {
        }
        field(15; Comment; Text[100])
        {
        }
        field(16; "No. Series"; Code[20])
        {
        }
        field(17; Status; Option)
        {
            OptionMembers = Open,"Pending Approval",Released;
        }
        field(18; "No. Printed"; Integer)
        {
        }
        field(19; Type; Option)
        {
            OptionMembers = " ","Test Drive","Gate Pass";
        }
        field(20; "Credit Approved"; Option)
        {
            OptionMembers = " ",Yes,No;
        }
        field(21; "Released By"; Code[30])
        {
        }
        field(22; "Released Date"; Date)
        {
        }
        field(23; "Released Time"; Time)
        {
        }
    }

    keys
    {
        key(Key1; "Gate Pass No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Gate Pass No." = '' THEN BEGIN
            ServiceSetup.GET;
            ServiceSetup.TESTFIELD(ServiceSetup."Service Invoice Nos.");
            NoSeriesMgt.InitSeries(ServiceSetup."Service Invoice Nos.", xRec."No. Series", 0D, "Gate Pass No.", "No. Series");
        END;

        Date := TODAY;
    end;

    var
        ServiceItemLine: Record 5901;
        NoSeriesMgt: Codeunit 396;
        ServiceSetup: Record 5911;
        Customer: Record 18;
        CustLedgEntry: Record 21;
}

