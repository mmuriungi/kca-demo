page 50148 "FIN-Cheaque Collection List"
{
    ApplicationArea = All;
    Caption = 'FIN-Cheaque Collection List';
    PageType = List;
    CardPageId = "FIN-Cheaque Header Card";
    SourceTable = "FIN-Cheaque Collection Header";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
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
