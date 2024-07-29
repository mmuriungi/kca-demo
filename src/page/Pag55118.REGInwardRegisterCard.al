page 55118 "REG-Inward Register Card"
{
    Caption = 'REG-Inward Register Card';
    PageType = Card;
    SourceTable = "Inward Register B";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
                field("File Date"; Rec."File Date")
                {
                    ToolTip = 'Specifies the value of the File Date field.';
                    ApplicationArea = All;
                }
                field("From Whom"; Rec."From Whom")
                {
                    ToolTip = 'Specifies the value of the From Whom field.';
                    ApplicationArea = All;
                }
                field("Ref No."; Rec."Ref No.")
                {
                    ToolTip = 'Specifies the value of the Ref No. field.';
                    ApplicationArea = All;
                }
                field(Subject; Rec.Subject)
                {
                    ToolTip = 'Specifies the value of the Subject field.';
                    ApplicationArea = All;
                }
                field("File Index"; Rec."File Index")
                {
                    ToolTip = 'Specifies the value of the File Index field.';
                    ApplicationArea = All;
                }
                field(Region; Rec.Region)
                {
                    ToolTip = 'Specifies the value of the Region field.';
                    ApplicationArea = All;
                }
                field("Region Name"; Rec."Region Name")
                {
                    ToolTip = 'Specifies the value of the Region Name field.';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action(EDMS)
            {
                ApplicationArea = All;
                Caption = 'Attach Folio';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                RunObject = Page "REG-Doc Attach Details";
                RunPageLink = "No." = field("File Index"), Closed = const(false), Archived = const(false);
            }
        }
    }
}
