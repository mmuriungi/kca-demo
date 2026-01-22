table 50114 "FIN-Asset Transfer Header"
{
    Caption = 'FIN-Asset Transfer Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(3; "Asset No"; Code[20])
        {
            Caption = 'Asset No';
            TableRelation = "Fixed Asset"."No.";
            trigger OnValidate()
            begin

                FA.Reset;
                FA.SetRange("No.", Rec."Asset No");
                if FA.Find('-') then begin
                    Rec."Asset Description" := FA.Description;
                    Rec."Current User" := fa."Responsible Officer";
                    Rec."Current Location" := FA."FA Location Code";
                    ObjEmp.Reset();
                    ObjEmp.SetRange("No.", Rec."Current User");
                    if ObjEmp.FindFirst() then
                        "Current User Name" := ObjEmp."First Name" + ' ' + ObjEmp."Middle Name" + ' ' + ObjEmp."Last Name";
                    "Current Name" := ObjEmp."Department Name";
                    if ObjEmp.Get("New User") then begin

                        "New User Name" := ObjEmp."First Name" + ' ' + ObjEmp."Middle Name" + ' ' + ObjEmp."Last Name";

                    end;
                    // ObjEmp.Reset;
                    // ObjEmp.SetRange("No.",ObjEmp."No.");
                    // ObjEmp.SetFilter("User ID",Rec."Created By");
                    // if ObjEmp.find 

                end;
            end;
        }
        field(4; "Current Location"; Code[20])
        {
            Caption = 'Current Location';
            TableRelation = "FA Location".code;
        }
        field(5; "New Location"; Code[20])
        {
            Caption = 'New Location';
            TableRelation = "FA Location".code;
        }
        field(6; "Reason for Transfer"; Text[250])
        {
            Caption = 'Reason for Transfer';
        }
        field(7; "Reason 2 for Transfer"; Text[250])
        {
            Caption = 'Reason 2 for Transfer';
        }
        field(8; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Pending,"Pending Approval",Approved,Cancelled,Posted;
            Editable = false;
            Description = 'Stores the status of the record in the database';
        }
        field(9; "Current User"; Code[20])
        {
            Caption = 'Current User';
        }
        field(10; "New User"; Code[20])
        {
            Caption = 'New User';
        }
        field(11; "Current Condition"; Option)
        {
            Caption = 'Current Condition';
            OptionMembers = Good,Bad,Obsolete;
        }
        field(30; "Global Dimension 1 Code"; Code[30])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                DimVal.RESET;
                DimVal.SETRANGE(DimVal."Global Dimension No.", 1);
                DimVal.SETRANGE(DimVal.Code, "Global Dimension 1 Code");
                IF DimVal.FIND('-') THEN
                    "Current Name" := DimVal.Name;
                //UpdateLines;
            end;
        }

        field(56; "Current  Dimension 2 Code"; Code[30])
        {
            CaptionClass = '1,2,2';
            Caption = 'Current Shortcut Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                DimVal.RESET;
                DimVal.SETRANGE(DimVal."Global Dimension No.", 2);
                DimVal.SETRANGE(DimVal.Code, "New Shortcut Dimension 2 Code");
                IF DimVal.FIND('-') THEN
                    "Budget Center Name" := DimVal.Name;
                //UpdateLines
            end;
        }
        field(57; "Current Name"; Text[100])
        {
            Description = 'Stores the name of the function in the database';
        }
        field(58; "Budget Center Name"; Text[150])
        {
            Description = 'Stores the name of the budget center in the database';
        }
        field(59; "New Shortcut Dimension 2 Code"; Code[30])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                DimVal.RESET;
                DimVal.SETRANGE(DimVal."Global Dimension No.", 2);
                DimVal.SETRANGE(DimVal.Code, "new Shortcut Dimension 2 Code");
                IF DimVal.FIND('-') THEN
                    "Budget Center Name" := DimVal.Name;
                // UpdateLines
            end;
        }
        field(38; "New Department name"; text[250])
        {

        }
        field(60; "No. Series"; code[20])
        {

        }
        field(61; "Current User Name"; text[250])
        {

        }
        field(63; "New User Name"; text[250])
        {

        }
        field(64; "Asset Description"; text[250])
        {

        }
        field(65; "FA Posting Group"; code[20])
        {

        }
        field(66; "Posted"; Boolean)
        {

        }
        field(67; "Created By"; code[20])
        {

        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    var
        DimVal: record "Dimension Value";
        GenLedgerSetup: Record "Cash Office Setup";
        NoSeriesMgt: Codeunit 396;
        FA: Record "Fixed Asset";
        usersetup: Record "User Setup";

        ObjEmp: Record "HRM-Employee C";



    trigger OnInsert()
    begin


        IF "No." = '' THEN BEGIN
            GenLedgerSetup.GET;
            GenLedgerSetup.TestField("FA Movement Nos");

            //IF "Payment Type" = "Payment Type"::Imprest THEN BEGIN
            GenLedgerSetup.TESTFIELD(GenLedgerSetup."FA Movement Nos");
            NoSeriesMgt.InitSeries(GenLedgerSetup."FA Movement Nos", xRec."No. Series", 0D, "No.", "No. Series");
            "Document Date" := TODAY;
            Rec."Created By" := UserId;
            if usersetup.Get(UserId) then begin
                usersetup.TestField("Staff No");
                rec."New User" := usersetup."Staff No";
                ObjEmp.reset;
                ObjEmp.SetRange("No.", Rec."New User");
                if ObjEmp.FindFirst() then
                    Rec."New User Name" := ObjEmp."First Name" + ' ' + ObjEmp."Middle Name" + '' + ObjEmp."Middle Name";

            end;


            //END
            // ObjEmp.Reset;
            // ObjEmp.TestField("User ID");
            // ObjEmp.SetFilter(ObjEmp."User ID", '%1', Rec."Created By");
            // if ObjEmp.FindFirst() then begin
            //     ObjEmp.TestField("Department Code");
            //     Rec."New User" := ObjEmp."No.";
            //     Rec."New User Name" := ObjEmp."First Name" + ' ' + ObjEmp."Middle Name" + '' + ObjEmp."Middle Name";
            //     Rec."New Shortcut Dimension 2 Code" := ObjEmp."Department Code";
            //     rec."New Department name" := ObjEmp."Department Name";
            // end;
        END;
    end;

}
