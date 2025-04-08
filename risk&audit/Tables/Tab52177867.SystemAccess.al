table 50144 "System Access"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
            trigger OnValidate()
            begin

                if "Document No." <> xRec."Document No." then
                    NoSeriesMgt.TestManual(ICTSetup."System Access Nos");
            end;
        }
        field(2; " Description"; Text[250])
        {
        }
        field(3; "Incident Date"; Date)
        {
        }
        field(4; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(5; "Employee No"; Code[20])
        {
            TableRelation = Employee;
            trigger OnValidate()
            var
                DimValues: Record "Dimension Value";
            begin
                IF Employee.GET("Employee No") THEN BEGIN
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    Designation := Employee."Job Title";
                    DimValues.SetRange(Code, Employee."Global Dimension 1 Code");
                    if DimValues.FindFirst() then
                        Department := DimValues.Name;
                    UserSetup.SetRange("Employee No.", Employee."No.");
                    if UserSetup.FindFirst() then
                        "User ID" := UserSetup."User ID";

                END;
            end;
        }
        field(6; "Employee Name"; Text[100])
        {
        }
        field(7; "User ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "System Name"; Text[100])
        {
            caption = 'System Role/Profile Name';
            DataClassification = ToBeClassified;
        }
        field(9; Designation; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Department; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Supervisor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                Employee.SetRange("No.", "Supervisor No.");
                if Employee.FindFirst() then
                    "Supervisor Name" := Employee."First Name" + ' ' + Employee."Middle Name" + '' + Employee."Last Name";

            end;
        }
        field(12; "Supervisor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Employee confirm access"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Employee confirm access date" := today;
            end;
        }
        field(14; "Supervisor confirm access"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Supervisor confirm access date" := today;
            end;
        }
        field(15; "Employee confirm access date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Supervisor confirm access date"; Date)
        {
            DataClassification = ToBeClassified;
        }



    }

    keys
    {
        key(Key1; "Document No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Document No.")
        {
        }
    }

    trigger OnInsert()
    begin
        if not ICTSetup.Get then begin
            ICTSetup.Init();
            ICTSetup.Insert();
        end;
        ICTSetup.TestField("System Access Nos");
        NoSeriesMgt.InitSeries(ICTSetup."System Access Nos", xRec."No. Series", Today, "Document No.", "No. Series");

    end;

    var
        ICTSetup: Record "ICT Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CompanyInformation: Record "Company Information";
        UserSetup: Record "User Setup";
        Employee: Record Employee;
        DimMgt: Codeunit DimensionManagement;


}

