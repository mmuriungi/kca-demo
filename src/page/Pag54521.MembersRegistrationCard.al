page 54521 "Members Registration Card"
{
    Caption = 'Members Registration Card';
    PageType = Card;
    SourceTable = "Cafe Members";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Member Type"; Rec."Member Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Type field.', Comment = '%';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Card Serial"; Rec."Card Serial")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Card Serial field.', Comment = '%';
                }

                field(Names; Rec.Names)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Names field.', Comment = '%';
                }
                field("Cafe Balance"; Rec."Cafe Balance")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cafe Balance field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Pic; Rec.Pic)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pic field.', Comment = '%';
                }

            }

        }

    }
    actions
    {
        area(Processing)
        {
            action("Meal Card")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = process;
                Image = Card;
                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetRange("No.", Rec."No.");
                    if rec.find('-') then begin
                        Report.Run(Report::"Meal Card", false, true, Rec);
                    end;
                end;
            }
        }
    }
}
