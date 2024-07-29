page 50929 "HRM-Applicant Qualif. lines"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "HRM-Applicant Qualif. Lines";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Qualification code"; Rec."Qualification code")
                {
                }
                field("Qualification Description"; Rec."Qualification Description")
                {
                }
                field("From Date"; Rec."From Date")
                {
                }
                field("To Date"; Rec."To Date")
                {

                    trigger OnValidate()
                    begin
                        if (Rec."To Date" <> 0D) and (Rec."From Date" <> 0D) then
                            Rec."No of Years" := Rec."To Date" - Rec."From Date";
                    end;
                }
                field(Institution; Rec.Institution)
                {
                }
                field("Qualification Type"; Rec."Qualification Type")
                {
                }
                field("No of Years"; Rec."No of Years")
                {
                    Caption = 'No of days';
                    Editable = false;
                }
                field("Actual Score"; Rec."Actual Score")
                {
                }
                field("Desired Score"; Rec."Desired Score")
                {
                    Editable = false;
                }
                field(Qualified; Rec.Qualified)
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        Year: Integer;
}

