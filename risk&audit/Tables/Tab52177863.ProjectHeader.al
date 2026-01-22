table 50157 "Project Header(new)"
{
    Caption = 'Contract';
    DrillDownPageID = "Projects List";
    LookupPageID = "Projects List";

    fields
    {
        field(1; "No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Project Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Project Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Estimated Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Estimated End Date" > 0D then
                    "Estimated Duration" := "Estimated End Date" - "Estimated Start Date";
            end;
        }
        field(5; "Estimated End Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Estimated Start Date");
                if "Estimated End Date" < "Estimated Start Date" then
                    Error(DateError);
                "Estimated Duration" := CreateDateTime("Estimated End Date", 0T) - CreateDateTime("Estimated Start Date", 0T);
            end;
        }
        field(6; "Estimated Duration"; Duration)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Actual Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Actual End Date" > 0D then
                    "Actual Duration" := CreateDateTime("Actual End Date", 0T) - CreateDateTime("Actual Start Date", 0T);
            end;
        }
        field(8; "Actual End Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Actual Start Date");
                if "Actual End Date" < "Actual Start Date" then
                    Error(DateError);
                "Actual Duration" := CreateDateTime("Actual End Date", 0T) - CreateDateTime("Actual Start Date", 0T);
                Modify;
            end;
        }
        field(9; "Actual Duration"; Duration)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Approved,Finished,Suspended,Rejected,Verified,"Pending Verification",Extended,Terminated,Renewed;
        }
        field(11; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(12; "Project Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Contract No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Contract Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "User ID"; Code[25])
        {
            DataClassification = ToBeClassified;
            TableRelation = User;
        }
        field(17; Contractor; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18; Recommendations; Text[250])
        {
            Editable = true;
            DataClassification = ToBeClassified;
        }
        field(19; "Contract Type"; Option)
        {
            OptionMembers = "",General,Maintenance,Goods,Service;
        }
        field(20; "Extend From"; Date)
        {

        }
        field(21; "Extend To"; Date)
        {

        }
        field(22; "Vendor No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if Vendor.Get("Vendor No") then begin
                    Name := Vendor.Name;
                    "Physical Address" := Vendor.Address;
                    "Postal Address" := Vendor.Address;
                    City := Vendor.City;
                    "E-mail" := Vendor."E-Mail";
                    "Telephone No" := Vendor."Phone No.";
                    "Fax No" := Vendor."Fax No.";
                    "Fax No." := Vendor."Fax No.";
                end;
            end;
        }
        field(32; Name; Text[100])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(23; "Physical Address"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Postal Address"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(25; City; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "E-mail"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Telephone No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Mobile No"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Fax No"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
            DataClassification = ToBeClassified;
        }
        field(31; "Termination Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Termination Reason"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Terminated By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "DepartmentCode"; Code[25])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(1));
        }
        field(36; "End of Contract Note sent"; Boolean)
        {

        }
        field(37; "Renewal Date"; Date)
        {

        }
        field(38; "Renewal Comments"; Text[250])
        {

        }
        field(39; "Renewal Duration"; Integer)
        {

        }
        field(40; "Payment Frequency"; Option)
        {
            OptionMembers = Monthly,Quarterly,"Semi-Annually",Annually,Weekly;
            OptionCaption = 'Monthly,Quarterly,Semi-Annually,Annually,Weekly';
            trigger Onvalidate()
            var
                myInt: Integer;
            begin

            end;
        }
        field(41; "Frequency Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Installments"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Payment Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Expense Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Expense Code".Code;
        }
        field(45; "Has Invoiced Lines"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Contract End Notification"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Reference No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            GeneralSetUp.Get;
            GeneralSetUp.TESTFIELD("Project Mgt Nos");
            NoSeriesManagement.InitSeries(GeneralSetUp."Project Mgt Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Project Date" := Today;
        "User ID" := UserId;
    end;

    var
        GeneralSetUp: Record "Purchases & Payables Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        DateError: Label 'End Date cannot come before Start Date';
        ProjectDuration: DateTime;
        Vendor: Record Vendor;
        PostCode: Record "Post Code";
}

