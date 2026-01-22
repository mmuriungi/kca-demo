table 50116 "Workplan Entry"
{
    Caption = 'Workplan Entry';
    DrillDownPageID = "W/P Budget Entries";
    LookupPageID = "W/P Budget Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Workplan Code"; Code[20])
        {
            TableRelation = Workplan;
        }
        field(3; "Activity Code"; Code[20])
        {
            TableRelation = "Workplan Activities";
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
            ClosingDates = true;

            trigger OnValidate()
            begin
                WorkPlanAct.RESET;
                WorkPlanAct.SETRANGE(WorkPlanAct."Activity Code", "Activity Code"); //Activity Code
                WorkPlanAct.SETRANGE(WorkPlanAct."Workplan Code", "Workplan Code"); //Workplan Plan Code
                IF WorkPlanAct.FIND('-') THEN BEGIN
                    //message('found');
                    "Global Dimension 1 Code" := WorkPlanAct."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := WorkPlanAct."Shortcut Dimension 2 Code";
                    "Expense Code" := WorkPlanAct."Expense Code";
                    "Account Type" := WorkPlanAct."Account Type";
                    "G/L Account No." := WorkPlanAct."No.";
                    Description := WorkPlanAct."Activity Description";
                    VALIDATE("Global Dimension 1 Code");
                    VALIDATE("Global Dimension 2 Code");
                    VALIDATE("G/L Account No.");
                END;
            end;
        }
        field(5; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                IF "Global Dimension 1 Code" = '' THEN
                    EXIT;
                GetGLSetup;
                ValidateDimValue(GLSetup."Global Dimension 1 Code", "Global Dimension 1 Code");
            end;
        }
        field(6; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                IF "Global Dimension 2 Code" = '' THEN
                    EXIT;
                GetGLSetup;
                ValidateDimValue(GLSetup."Global Dimension 2 Code", "Global Dimension 2 Code");
            end;
        }
        field(7; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(9; Description; Text[200])
        {
            Caption = 'Description';
        }
        field(10; "Business Unit Code"; Code[10])
        {
            Caption = 'Business Unit Code';
            TableRelation = "Business Unit";
        }
        field(11; "User ID"; Code[20])
        {
            Caption = 'User ID';
            Editable = false;
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
                //LoginMgt.LookupUserID("User ID");
            end;
        }
        field(12; "Budget Dimension 1 Code"; Code[20])
        {
            CaptionClass = GetCaptionClass(1);
            Caption = 'Budget Dimension 1 Code';

            trigger OnLookup()
            begin
                "Budget Dimension 1 Code" := OnLookupDimCode(2, "Budget Dimension 1 Code");
            end;

            trigger OnValidate()
            begin
                IF "Budget Dimension 1 Code" = '' THEN
                    EXIT;
                IF GLBudgetName."Workplan Code" <> "Workplan Code" THEN
                    GLBudgetName.GET("Workplan Code");
                ValidateDimValue(GLBudgetName."Budget Dimension 1 Code", "Budget Dimension 1 Code");
            end;
        }
        field(13; "Budget Dimension 2 Code"; Code[20])
        {
            CaptionClass = GetCaptionClass(2);
            Caption = 'Budget Dimension 2 Code';

            trigger OnLookup()
            begin
                "Budget Dimension 2 Code" := OnLookupDimCode(3, "Budget Dimension 2 Code");
            end;

            trigger OnValidate()
            begin
                IF "Budget Dimension 2 Code" = '' THEN
                    EXIT;
                IF GLBudgetName."Workplan Code" <> "Workplan Code" THEN
                    GLBudgetName.GET("Workplan Code");
                ValidateDimValue(GLBudgetName."Budget Dimension 2 Code", "Budget Dimension 2 Code");
            end;
        }
        field(14; "Budget Dimension 3 Code"; Code[20])
        {
            CaptionClass = GetCaptionClass(3);
            Caption = 'Budget Dimension 3 Code';

            trigger OnLookup()
            begin
                "Budget Dimension 3 Code" := OnLookupDimCode(4, "Budget Dimension 3 Code");
            end;

            trigger OnValidate()
            begin
                IF "Budget Dimension 3 Code" = '' THEN
                    EXIT;
                IF GLBudgetName."Workplan Code" <> "Workplan Code" THEN
                    GLBudgetName.GET("Workplan Code");
                ValidateDimValue(GLBudgetName."Budget Dimension 3 Code", "Budget Dimension 3 Code");
            end;
        }
        field(15; "Budget Dimension 4 Code"; Code[20])
        {
            CaptionClass = GetCaptionClass(4);
            Caption = 'Budget Dimension 4 Code';

            trigger OnLookup()
            begin
                "Budget Dimension 4 Code" := OnLookupDimCode(5, "Budget Dimension 4 Code");
            end;

            trigger OnValidate()
            begin
                IF "Budget Dimension 4 Code" = '' THEN
                    EXIT;
                IF GLBudgetName."Workplan Code" <> "Workplan Code" THEN
                    GLBudgetName.GET("Workplan Code");
                ValidateDimValue(GLBudgetName."Budget Dimension 4 Code", "Budget Dimension 4 Code");
            end;
        }
        field(16; "Budget Dimension 5 Code"; Code[10])
        {

            trigger OnValidate()
            begin
                /*
                IF "Budget Dimension 5 Code" <> xRec."Budget Dimension 5 Code" THEN BEGIN
                  IF Dim.CheckIfDimUsed("Budget Dimension 5 Code",12,Name,'',0) THEN
                    ERROR(Text000,Dim.GetCheckDimErr);
                  MODIFY;
                  UpdateBudgetDim("Budget Dimension 5 Code",4);
                END;
                */

            end;
        }
        field(17; "Budget Dimension 6 Code"; Code[20])
        {
            Caption = 'Budget Dimension 4 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                /*
                IF "Budget Dimension 6 Code" <> xRec."Budget Dimension 6 Code" THEN BEGIN
                  IF Dim.CheckIfDimUsed("Budget Dimension 6 Code",12,Name,'',0) THEN
                    ERROR(Text000,Dim.GetCheckDimErr);
                  MODIFY;
                  UpdateBudgetDim("Budget Dimension 6 Code",5);
                END;
                */

            end;
        }
        field(18; Units; Code[40])
        {
        }
        field(19; "Unit Cost"; Decimal)
        {

            trigger OnValidate()
            begin
                Amount := Quantity * "Unit Cost";
            end;
        }
        field(20; Quantity; Decimal)
        {

            trigger OnValidate()
            begin
                Amount := Quantity * "Unit Cost";
            end;
        }
        field(21; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = ' ,G/L Account,Item';
            OptionMembers = " ","G/L Account",Item;
        }
        field(22; "G/L Account No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF ("Account Type" = CONST(Item)) Item."No." WHERE(Blocked = CONST(false))
            ELSE
            IF ("Account Type" = CONST("G/L Account")) "G/L Account"."No." WHERE(Blocked = CONST(false));
            //"Expense Code" = FIELD("Expense Code"));

            trigger OnValidate()
            var
                GLAcc: Record "G/L Account";
                Item: Record "Item";
            begin
                CASE "Account Type" OF
                    "Account Type"::"G/L Account":
                        BEGIN
                            GLAcc.GET("G/L Account No.");
                            GLAcc.TESTFIELD(Blocked, FALSE);
                            Description := GLAcc.Name;
                        END;
                    "Account Type"::Item:
                        BEGIN
                            Item.GET("G/L Account No.");
                            Item.TESTFIELD(Blocked, FALSE);
                            Item.TESTFIELD("Inventory Posting Group");
                            Item.TESTFIELD("Gen. Prod. Posting Group");
                            Description := Item.Description;
                        END;
                END;
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions;
            end;
        }
        field(50000; "Expense Code"; Code[30])
        {
            TableRelation = "Expense Code";
        }
        field(50001; "Created By:"; Text[250])
        {
        }
        field(50002; "Last Modified By:"; Text[250])
        {
        }
        field(50003; "Processed to Budget"; Boolean)
        {

            trigger OnValidate()
            begin
                WorkPlanAct.RESET;
                WorkPlanAct.SETRANGE(WorkPlanAct."Activity Code", "Activity Code");
                WorkPlanAct.SETRANGE(WorkPlanAct."Workplan Code", "Workplan Code");
                IF WorkPlanAct.FIND('-') THEN BEGIN
                    WorkPlanAct."Converted to Budget" := TRUE;
                    WorkPlanAct."Converted to Budget by:" := USERID;
                    WorkPlanAct.MODIFY;
                END;
            end;
        }
        field(50004; "Entry Type"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Reversal';
            OptionMembers = " ",Reversal;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Workplan Code", "Activity Code", Date)
        {
            SumIndexFields = Amount, Quantity;
        }
        key(Key3; "Workplan Code", "Activity Code", "Business Unit Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Budget Dimension 1 Code", "Budget Dimension 2 Code", "Budget Dimension 3 Code", "Budget Dimension 4 Code", Date, "G/L Account No.")
        {
            SumIndexFields = Amount, Quantity;
        }
        key(Key4; "Workplan Code", "Activity Code", Description, Date)
        {
        }
        key(Key5; "G/L Account No.", "Global Dimension 2 Code")
        {
            SumIndexFields = Amount, Quantity;
        }
        key(Key6; "G/L Account No.")
        {
        }
        key(Key7; "Workplan Code", "G/L Account No.", "Business Unit Code", "Global Dimension 1 Code")
        {
        }
        key(Key8; "Workplan Code", "Activity Code", "Business Unit Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Budget Dimension 1 Code", "Budget Dimension 2 Code", "Budget Dimension 3 Code", "Budget Dimension 4 Code", Date)
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        GLBudgetDim: Record "Workplan Dimension";
    begin
        CheckIfBlocked;
        //Was Checking for GL Dimensions
        GLBudgetDim.SETRANGE("Entry No.", "Entry No.");
        GLBudgetDim.DELETEALL;
    end;

    trigger OnInsert()
    begin
        CheckIfBlocked;
        TESTFIELD(Date);
        TESTFIELD("Activity Code");
        TESTFIELD("Workplan Code");
        //Ensure cannot post to Totalling fields
        IF NOT GetGLAccount("Activity Code") THEN
            ERROR('Account No %1 does not allow Budgetting', "Activity Code");

        LOCKTABLE;
        "User ID" := USERID;
        IF "Entry No." = 0 THEN
            "Entry No." := GetNextEntryNo;

        GetGLSetup;
        UpdateDim(GLSetup."Global Dimension 1 Code", "Global Dimension 1 Code");
        UpdateDim(GLSetup."Global Dimension 2 Code", "Global Dimension 2 Code");
        UpdateDim(GLBudgetName."Budget Dimension 1 Code", "Budget Dimension 1 Code");
        UpdateDim(GLBudgetName."Budget Dimension 2 Code", "Budget Dimension 2 Code");
        UpdateDim(GLBudgetName."Budget Dimension 3 Code", "Budget Dimension 3 Code");
        UpdateDim(GLBudgetName."Budget Dimension 4 Code", "Budget Dimension 4 Code");

        //***************************************************************************
        "Created By:" := USERID + ' on ' + FORMAT(CREATEDATETIME(TODAY, TIME));
    end;

    trigger OnModify()
    begin
        CheckIfBlocked;
        "User ID" := USERID;
        GetGLSetup;
        IF "Global Dimension 1 Code" <> xRec."Global Dimension 1 Code" THEN
            UpdateDim(GLSetup."Global Dimension 1 Code", "Global Dimension 1 Code");
        IF "Global Dimension 2 Code" <> xRec."Global Dimension 2 Code" THEN
            UpdateDim(GLSetup."Global Dimension 2 Code", "Global Dimension 2 Code");
        IF "Budget Dimension 1 Code" <> xRec."Budget Dimension 1 Code" THEN
            UpdateDim(GLBudgetName."Budget Dimension 1 Code", "Budget Dimension 1 Code");
        IF "Budget Dimension 2 Code" <> xRec."Budget Dimension 2 Code" THEN
            UpdateDim(GLBudgetName."Budget Dimension 2 Code", "Budget Dimension 2 Code");
        IF "Budget Dimension 3 Code" <> xRec."Budget Dimension 3 Code" THEN
            UpdateDim(GLBudgetName."Budget Dimension 3 Code", "Budget Dimension 3 Code");
        IF "Budget Dimension 4 Code" <> xRec."Budget Dimension 4 Code" THEN
            UpdateDim(GLBudgetName."Budget Dimension 4 Code", "Budget Dimension 4 Code");

        //***************************************************************************
        "Last Modified By:" := USERID + ' on ' + FORMAT(CREATEDATETIME(TODAY, TIME));
    end;

    var
        Text000: Label 'The dimension value %1 has not been set up for dimension %2.';
        Text001: Label '1,5,,Budget Dimension 1 Code';
        Text002: Label '1,5,,Budget Dimension 2 Code';
        Text003: Label '1,5,,Budget Dimension 3 Code';
        Text004: Label '1,5,,Budget Dimension 4 Code';
        GLBudgetName: Record "Workplan";
        GLSetup: Record "General Ledger Setup";
        GLSetupRetrieved: Boolean;
        WorkPlanAct: Record "Workplan Activities";

    procedure CheckIfBlocked()
    begin
        IF "Workplan Code" = GLBudgetName."Workplan Code" THEN
            EXIT;
        IF GLBudgetName."Workplan Code" <> "Workplan Code" THEN
            GLBudgetName.GET("Workplan Code");
        GLBudgetName.TESTFIELD(Blocked, FALSE);
    end;

    local procedure ValidateDimValue(DimCode: Code[20]; var DimValueCode: Code[20]): Boolean
    var
        DimValue: Record "Dimension Value";
    begin
        DimValue."Dimension Code" := DimCode;
        DimValue.Code := DimValueCode;
        DimValue.FIND('=><');
        IF DimValueCode <> COPYSTR(DimValue.Code, 1, STRLEN(DimValueCode)) THEN
            ERROR(Text000, DimValueCode, DimCode);
        DimValueCode := DimValue.Code;
    end;

    procedure GetGLSetup()
    begin
        IF NOT GLSetupRetrieved THEN BEGIN
            GLSetup.GET;
            GLSetupRetrieved := TRUE;
        END;
    end;

    procedure OnLookupDimCode(DimOption: Option "Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4"; DefaultValue: Code[20]): Code[20]
    var
        DimValue: Record "Dimension Value";
        DimValueList: Page "Dimension Value List";
    begin
        IF DimOption IN [DimOption::"Global Dimension 1", DimOption::"Global Dimension 2"] THEN
            GetGLSetup
        ELSE
            IF GLBudgetName."Workplan Code" <> "Workplan Code" THEN
                GLBudgetName.GET("Workplan Code");
        CASE DimOption OF
            DimOption::"Global Dimension 1":
                DimValue."Dimension Code" := GLSetup."Global Dimension 1 Code";
            DimOption::"Global Dimension 2":
                DimValue."Dimension Code" := GLSetup."Global Dimension 2 Code";
            DimOption::"Budget Dimension 1":
                DimValue."Dimension Code" := GLBudgetName."Budget Dimension 1 Code";
            DimOption::"Budget Dimension 2":
                DimValue."Dimension Code" := GLBudgetName."Budget Dimension 2 Code";
            DimOption::"Budget Dimension 3":
                DimValue."Dimension Code" := GLBudgetName."Budget Dimension 3 Code";
            DimOption::"Budget Dimension 4":
                DimValue."Dimension Code" := GLBudgetName."Budget Dimension 4 Code";
        END;
        DimValue.SETRANGE("Dimension Code", DimValue."Dimension Code");
        IF DimValue.GET(DimValue."Dimension Code", DefaultValue) THEN;
        DimValueList.SETTABLEVIEW(DimValue);
        DimValueList.SETRECORD(DimValue);
        DimValueList.LOOKUPMODE := TRUE;
        IF DimValueList.RUNMODAL = ACTION::LookupOK THEN BEGIN
            DimValueList.GETRECORD(DimValue);
            EXIT(DimValue.Code);
        END ELSE
            EXIT(DefaultValue);
    end;

    procedure UpdateDim(DimCode: Code[20]; DimValueCode: Code[20])
    var
        GLBudgetDim: Record "Workplan Dimension";
    begin

        //Workplan Dimensions
        IF DimCode = '' THEN
            EXIT;
        IF GLBudgetDim.GET(Rec."Entry No.", DimCode) THEN
            GLBudgetDim.DELETE;
        IF DimValueCode <> '' THEN BEGIN
            GLBudgetDim.INIT;
            GLBudgetDim."Entry No." := Rec."Entry No.";
            GLBudgetDim."Dimension Code" := DimCode;
            GLBudgetDim."Dimension Value Code" := DimValueCode;
            GLBudgetDim.INSERT;
        END;
    end;

    local procedure GetNextEntryNo(): Integer
    var
        GLBudgetEntry: Record "Workplan Entry";
    begin
        GLBudgetEntry.SETCURRENTKEY("Entry No.");
        IF GLBudgetEntry.FIND('+') THEN
            EXIT(GLBudgetEntry."Entry No." + 1)
        ELSE
            EXIT(1);
    end;

    procedure GetCaptionClass(BudgetDimType: Integer): Text[250]
    begin
        IF GLBudgetName."Workplan Code" <> "Workplan Code" THEN
            IF NOT GLBudgetName.GET("Workplan Code") THEN
                EXIT('');
        CASE BudgetDimType OF
            1:
                BEGIN
                    IF GLBudgetName."Budget Dimension 1 Code" <> '' THEN
                        EXIT('1,5,' + GLBudgetName."Budget Dimension 1 Code")
                    ELSE
                        EXIT(Text001);
                END;
            2:
                BEGIN
                    IF GLBudgetName."Budget Dimension 2 Code" <> '' THEN
                        EXIT('1,5,' + GLBudgetName."Budget Dimension 2 Code")
                    ELSE
                        EXIT(Text002);
                END;
            3:
                BEGIN
                    IF GLBudgetName."Budget Dimension 3 Code" <> '' THEN
                        EXIT('1,5,' + GLBudgetName."Budget Dimension 3 Code")
                    ELSE
                        EXIT(Text003);
                END;
            4:
                BEGIN
                    IF GLBudgetName."Budget Dimension 4 Code" <> '' THEN
                        EXIT('1,5,' + GLBudgetName."Budget Dimension 4 Code")
                    ELSE
                        EXIT(Text004);
                END;
        END;
    end;

    procedure GetGLAccount(GLCode: Code[20]) AllowPosting: Boolean
    var
        GLAccount: Record "Workplan Activities";
    begin
        AllowPosting := FALSE;
        IF GLAccount.GET(GLCode) THEN BEGIN
            IF GLAccount."Account Type" = GLAccount."Account Type"::Posting THEN
                AllowPosting := TRUE
            ELSE
                AllowPosting := FALSE;
        END;
    end;

    procedure ShowDimensions()
    var
        DimSetEntry: Record "Dimension Set Entry";
        OldDimSetID: Integer;
    begin
        /*
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID",STRSUBSTNO('%1 %2 %3',"Budget Name","G/L Account No.","Entry No."));
        
        IF OldDimSetID = "Dimension Set ID" THEN
          EXIT;
        
        GetGLSetup;
        GLBudgetName.GET("Budget Name");
        
        "Global Dimension 1 Code" := '';
        "Global Dimension 2 Code" := '';
        "Budget Dimension 1 Code" := '';
        "Budget Dimension 2 Code" := '';
        "Budget Dimension 3 Code" := '';
        "Budget Dimension 4 Code" := '';
        
        IF DimSetEntry.GET("Dimension Set ID",GLSetup."Global Dimension 1 Code") THEN
          "Global Dimension 1 Code" := DimSetEntry."Dimension Value Code";
        IF DimSetEntry.GET("Dimension Set ID",GLSetup."Global Dimension 2 Code") THEN
          "Global Dimension 2 Code" := DimSetEntry."Dimension Value Code";
        IF DimSetEntry.GET("Dimension Set ID",GLBudgetName."Budget Dimension 1 Code") THEN
          "Budget Dimension 1 Code" := DimSetEntry."Dimension Value Code";
        IF DimSetEntry.GET("Dimension Set ID",GLBudgetName."Budget Dimension 2 Code") THEN
          "Budget Dimension 2 Code" := DimSetEntry."Dimension Value Code";
        IF DimSetEntry.GET("Dimension Set ID",GLBudgetName."Budget Dimension 3 Code") THEN
          "Budget Dimension 3 Code" := DimSetEntry."Dimension Value Code";
        IF DimSetEntry.GET("Dimension Set ID",GLBudgetName."Budget Dimension 4 Code") THEN
          "Budget Dimension 4 Code" := DimSetEntry."Dimension Value Code";
         */

    end;
}

