page 54920 "HMS-Radiology Test Line Image"
{
    PageType = Document;
    SourceTable = "HMS-Radiology Form Line";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Radiology no."; Rec."Radiology no.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Radiology Type Code"; Rec."Radiology Type Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Radiology Type Name"; Rec."Radiology Type Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Performed Date"; Rec."Performed Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Performed Time"; Rec."Performed Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Completed; Rec.Completed)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part(Part; "HMS-Radiology Test Line Images")
            {
                SubPageLink = "Radiology No." = FIELD("Radiology no."),
                              "Radiology Type Code" = FIELD("Radiology Type Code");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}

