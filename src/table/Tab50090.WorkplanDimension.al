table 50090 "Workplan Dimension"
{
    Caption = 'Workplan Dimension';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension Code';
            TableRelation = Dimension;
        }
        field(3; "Dimension Value Code"; Code[20])
        {
            Caption = 'Dimension Value Code';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Dimension Code"));
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Dimension Code")
        {
        }
        key(Key2; "Dimension Code", "Dimension Value Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        CheckIfBlocked;
        UpdateDimFields('');
    end;

    trigger OnInsert()
    begin
        TESTFIELD("Dimension Value Code");
        CheckIfBlocked;
        UpdateDimFields("Dimension Value Code");
    end;

    trigger OnModify()
    begin
        CheckIfBlocked;
        UpdateDimFields("Dimension Value Code");
    end;

    var
        GLSetup: Record "General Ledger Setup";
        GLSetupRetrieved: Boolean;

    procedure CheckIfBlocked()
    var
        GLBudgetName: Record "G/L Budget Name";
        GLBudgetEntry: Record "G/L Budget Entry";
    begin
        IF GLBudgetEntry.GET("Entry No.") THEN
            IF GLBudgetName.GET(GLBudgetEntry."Budget Name") THEN
                GLBudgetName.TESTFIELD(Blocked, FALSE);
    end;

    local procedure UpdateDimFields(NewDimValue: Code[20])
    var
        Modified: Boolean;
        GLBudgetName: Record "G/L Budget Name";
        GLBudgetEntry: Record "G/L Budget Entry";
    begin
        IF "Dimension Code" = '' THEN
            EXIT;
        IF NOT GLSetupRetrieved THEN BEGIN
            GLSetup.GET;
            GLSetupRetrieved := TRUE;
        END;

        IF GLBudgetEntry.GET("Entry No.") THEN BEGIN
            CASE "Dimension Code" OF
                GLSetup."Global Dimension 1 Code":
                    BEGIN
                        GLBudgetEntry."Global Dimension 1 Code" := NewDimValue;
                        Modified := TRUE;
                    END;
                GLSetup."Global Dimension 2 Code":
                    BEGIN
                        GLBudgetEntry."Global Dimension 2 Code" := NewDimValue;
                        Modified := TRUE;
                    END;
            END;
            IF GLBudgetName.GET(GLBudgetEntry."Budget Name") THEN BEGIN
                CASE "Dimension Code" OF
                    GLBudgetName."Budget Dimension 1 Code":
                        BEGIN
                            GLBudgetEntry."Budget Dimension 1 Code" := NewDimValue;
                            Modified := TRUE;
                        END;
                    GLBudgetName."Budget Dimension 2 Code":
                        BEGIN
                            GLBudgetEntry."Budget Dimension 2 Code" := NewDimValue;
                            Modified := TRUE;
                        END;
                    GLBudgetName."Budget Dimension 3 Code":
                        BEGIN
                            GLBudgetEntry."Budget Dimension 3 Code" := NewDimValue;
                            Modified := TRUE;
                        END;
                    GLBudgetName."Budget Dimension 4 Code":
                        BEGIN
                            GLBudgetEntry."Budget Dimension 4 Code" := NewDimValue;
                            Modified := TRUE;
                        END;
                END;
            END;
            IF Modified THEN BEGIN
                GLBudgetEntry."User ID" := USERID;
                GLBudgetEntry.MODIFY;
            END;
        END;
    end;
}

