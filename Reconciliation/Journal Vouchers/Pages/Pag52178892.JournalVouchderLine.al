page 52147 "Journal Vouchder Line"
{
    Caption = 'Journal Vouchder Line';
    PageType = ListPart;
    SourceTable = "Journal Voucher Lines";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Line No field.', Comment = '%';
                }
                field("Reference No"; Rec."Reference No")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Reference No field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Type field.', Comment = '%';
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account Type field.', Comment = '%';
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account No field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency Code field.', Comment = '%';
                }
                field(externalDocumentNo; Rec.externalDocumentNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the externalDocumentNo field.', Comment = '%';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.', Comment = '%';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bal. Account Type field.', Comment = '%';
                }

                field("Balancing Account No"; Rec."Balancing Account No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Balancing Account No field.', Comment = '%';
                }

                field(processed; Rec.processed)
                {
                    ApplicationArea = All;
                    // Visible = false;
                    Editable = false;
                    ToolTip = 'Specifies the value of the processed field.', Comment = '%';
                }

            }
        }
    }
}
