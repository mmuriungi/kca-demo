page 50797 "ACA-Applic. Form Batch View"
{
    PageType = Document;
    SourceTable = "ACA-Adm. Form Batch";

    layout
    {
        area(content)
        {
            repeater(___)
            {
                Editable = false;
                field("Batch No."; Rec."Batch No.")
                {
                    ApplicationArea = All;
                }
                field("Batch Date"; Rec."Batch Date")
                {
                    ApplicationArea = All;
                }
                field("Batch Time"; Rec."Batch Time")
                {
                    ApplicationArea = All;
                }
                field("No. Of Applications Pending"; Rec."No. Of Applications Pending")
                {
                    ApplicationArea = All;
                }
                field("No.Of Applications Ratified"; Rec."No.Of Applications Ratified")
                {
                    ApplicationArea = All;
                }
                field("No. Of Applications Rejected"; Rec."No. Of Applications Rejected")
                {
                    ApplicationArea = All;
                }
            }
#pragma warning disable AL0269
            part(AB; "ACA-Applic. Form Batch List")
#pragma warning restore AL0269
            {
                SubPageLink = "Batch No." = FIELD("Batch No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Print Summary")
            {
                Caption = '&Print Summary';
                Image = PrintForm;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*Print out the summary*/
                    Apps.RESET;
                    Apps.SETRANGE(Apps."Batch No.");
                    Apps.SETRANGE(Apps.Status, Apps.Status::"Admission Board");
                    REPORT.RUN(39005762, TRUE, TRUE, Apps);

                end;
            }
        }
    }

    var
        Apps: Record "ACA-Applic. Form Header";
}

