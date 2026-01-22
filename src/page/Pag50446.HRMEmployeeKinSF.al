page 50446 "HRM-Employee Kin SF"
{
    Caption = 'HR Employee Kin & Beneficiaries';
    PageType = ListPart;
    SourceTable = "HRM-Employee Kin";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                }
                field(Relationship; Rec.Relationship)
                {
                }
                field(SurName; Rec.SurName)
                {
                }
                field("Other Names"; Rec."Other Names")
                {
                }
                field("ID No/Passport No"; Rec."ID No/Passport No")
                {
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    Visible = true;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        /*
                        FrmCalendar.SetDate("Date Of Birth");
                        FrmCalendar.RUNMODAL;
                        D := FrmCalendar.GetDate;
                        CLEAR(FrmCalendar);
                        IF D <> 0D THEN
                          "Date Of Birth" := D;
                        */

                    end;
                }
                field("Percentage(%)"; Rec."Percentage(%)")
                {
                }
                field(Occupation; Rec.Occupation)
                {
                }
                field(Address; Rec.Address)
                {
                }
                field("Office Tel No"; Rec."Office Tel No")
                {
                }
                field("Home Tel No"; Rec."Home Tel No")
                {
                }
                field(Comment; Rec.Comment)
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("&Next of Kin")
            {
                Caption = '&Next of Kin';
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Employee Relative"),
                                  "No." = FIELD("Employee Code"),
                                  "Table Line No." = FIELD("Line No.");
                }
            }
        }
    }

    var
        D: Date;
}

