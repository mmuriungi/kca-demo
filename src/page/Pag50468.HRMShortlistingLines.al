page 50468 "HRM-Shortlisting Lines"
{
    Caption = 'Shorlisted Candidates';
    Editable = false;
    PageType = ListPart;
    SourceTable = "HRM-Shortlisted Applicants";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Qualified; Rec.Qualified)
                {
                    ApplicationArea = all;
                    Caption = 'Qualified';
                    Editable = true;

                    trigger OnValidate()
                    begin
                        Rec."Manual Change" := true;
                        Rec.Modify;
                    end;
                }
                field("Job Application No"; Rec."Job Application No")
                {
                    ApplicationArea = all;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = all;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = all;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = all;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = all;
                }
                field("Stage Score"; Rec."Stage Score")
                {
                    ApplicationArea = all;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = all;
                }
                field(Employ; Rec.Employ)
                {
                    ApplicationArea = all;
                    Caption = 'Employed';
                }
                field("Reporting Date"; Rec."Reporting Date")
                {
                    ApplicationArea = all;
                }
                field("Manual Change"; Rec."Manual Change")
                {
                    ApplicationArea = all;
                    Caption = 'Manual Change';
                }
            }
        }
    }

    actions
    {
    }

    var
        MyCount: Integer;

    procedure GetApplicantNo() AppicantNo: Code[20]
    begin
        //AppicantNo:=Applicant;
    end;
}

