/// <summary>
/// Page ACA-Application Form Acad. Ref (ID 68468).
/// </summary>
page 51859 "ACA-Application Form Acad. Ref"
{
    PageType = ListPart;
    SourceTable = "ACA-Applic. Form Academic Ref";

    layout
    {
        area(content)
        {
            repeater(__)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Telephone No."; Rec."Telephone No.")
                {
                    ApplicationArea = All;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

