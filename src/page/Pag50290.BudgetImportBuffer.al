page 50290 "Budget Import Buffer"
{
    Caption = 'Budget Import Buffer';
    PageType = Card;
    SourceTable = "Budget Import";
    DeleteAllowed = false;


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Budget Name"; Rec."Budget Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Budget Name field.', Comment = '%';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
            }
            part(budgetLine; "Budget Buffer Line")
            {
                SubPageLink = "No." = field("No."), "Global Dimension 1 Code" = field("Global Dimension 1 Code"), "Global Dimension 2 Code" = field("Global Dimension 2 Code");
                ApplicationArea = all;

            }
        }
    }
    actions
    {
        area(Creation)
        {
            action("Import Budget")
            {
                ApplicationArea = all;
                trigger OnAction()
                begin
                    if CONFIRM('Import Budget?', TRUE) = FALSE THEN EXIT;

                    PostBudget();
                end;

            }
        }
    }
    var
        BudgetEntries: record 96;
        LastEntryNo: Integer;
        PostBudgetEnties: Codeunit "Post Budget Enties";
        Budgetline: record "Budget Line";

    procedure PostBudget()
    begin
        if Rec.posted = false then begin
            Budgetline.reset;
            Budgetline.SetRange(Posted, false);
            Budgetline.SetRange("No.", Rec."No.");
            Budgetline.SetRange("Budget Name", rec."Budget Name");
            if Budgetline.Find('-') then begin
                repeat
                    BudgetEntries.Init();
                    BudgetEntries."Entry No." := getLastEntryno() + 1;
                    BudgetEntries."Budget Name" := Budgetline."Budget Name";
                    BudgetEntries.Date := Budgetline."Budget Date";
                    BudgetEntries."G/L Account No." := Budgetline."Gl Account";
                    BudgetEntries."Global Dimension 1 Code" := Budgetline."Global Dimension 1 Code";
                    BudgetEntries."Global Dimension 2 Code" := Budgetline."Global Dimension 2 Code";
                    BudgetEntries.Amount := Budgetline.Amount;
                    BudgetEntries.Insert()
                until Budgetline.Next() = 0;
                PostBudgetEnties.PostBudget();
                PostBudgetEnties.Run();
            end;

        end;
        Rec.posted := True;

    end;

    procedure getLastEntryno(): Integer
    var
        BudgetEntries1: record 96;
    begin
        if BudgetEntries1.FindLast() then
            exit(BudgetEntries1."Entry No.")
        else
            exit(0);


    end;

}
