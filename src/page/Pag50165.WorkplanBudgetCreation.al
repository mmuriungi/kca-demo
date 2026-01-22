page 50165 "Workplan Budget Creation"
{
    PageType = List;
    SourceTable = "Procur. Plan Budget Allocation";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Analysis Area"; Rec."Analysis Area")
                {
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Workplan Code';
                }
                field("Current G/L Budget"; Rec."Current G/L Budget")
                {
                    Editable = false;
                }
                field("Current Item Budget"; Rec."Current Item Budget")
                {
                    Editable = false;
                }
                field("Business Unit"; Rec."Business Unit")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Budget Dimension 1 Code"; Rec."Budget Dimension 1 Code")
                {
                    Caption = 'Budget Dimension 1 Code';
                    Enabled = FieldsEditable;
                    Visible = FieldsEditable;
                }
                field("Budget Dimension 2 Code"; Rec."Budget Dimension 2 Code")
                {
                    Caption = 'Budget Dimension 2 Code';
                    Enabled = FieldsEditable;
                    Visible = FieldsEditable;
                }
                field("Budget Dimension 3 Code"; Rec."Budget Dimension 3 Code")
                {
                    Caption = 'Budget Dimension 3 Code';
                    Enabled = FieldsEditable;
                    Visible = FieldsEditable;
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("Period Type"; Rec."Period Type")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Process)
            {
                Caption = 'Process';
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TESTFIELD("Start Date");
                    Rec.TESTFIELD("End Date");
                    IF CONFIRM('Process Allocation?', FALSE) = FALSE THEN BEGIN
                        ERROR('Processing Aborted');
                        EXIT;
                    END ELSE BEGIN
                        fnProcessAllocation;
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        Budget.RESET;
        Budget.SETRANGE(Budget."Workplan Code", Rec.Name);
        IF Budget.FIND('-') THEN BEGIN
            //Check if the budget dimension 1 is to be enabled
            IF Budget."Budget Dimension 1 Code" = '' THEN BEGIN
                FieldsEditable := FALSE;
            END
            ELSE BEGIN
                FieldsEditable := TRUE;
            END;
            IF Budget."Budget Dimension 2 Code" = '' THEN BEGIN
                FieldsEditable := FALSE;
            END
            ELSE BEGIN
                FieldsEditable := TRUE;
            END;
            IF Budget."Budget Dimension 3 Code" = '' THEN BEGIN
                FieldsEditable := FALSE;
            END
            ELSE BEGIN
                FieldsEditable := TRUE;
            END;
        END;
    end;

    var
        Budget: Record "Workplan";
        FieldsEditable: Boolean;
        BudgetAllocation: Codeunit "WP Budget Allocation";

    procedure fnProcessAllocation()
    begin
        Rec.SETRANGE("Line No.", Rec."Line No.");
        BudgetAllocation.CreateBudgetFromWorkplan(Rec);
    end;
}

