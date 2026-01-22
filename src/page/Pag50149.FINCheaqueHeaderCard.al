page 50149 "FIN-Cheaque Header Card"
{
    Caption = 'FIN-Cheque Header Card';
    PageType = Card;
    SourceTable = "FIN-Cheaque Collection Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = all;

                }

            }
            part("Collection Buffer"; "FIN-Cheque Collection Buffer ")
            {
                ApplicationArea = all;

                SubPageLink = No = FIELD("No.");

            }
        }

    }
    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Collection Register")
                {
                    Caption = 'Collection Register';
                    Image = Report2;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;


                    trigger OnAction()
                    begin
                        Rec.RESET;
                        Rec.SETFILTER("No.", Rec."No.");
                        REPORT.RUN(50036, TRUE, TRUE, Rec);
                        Rec.RESET;
                    end;
                }
            }
        }
    }
}
