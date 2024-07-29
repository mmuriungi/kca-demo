page 50266 "Proc Classifctn Requirements"
{
    Caption = 'Proc Classifctn Requirements';
    PageType = List;
    SourceTable = "Proc Classification Requiremnt";
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Mandatory; Rec.Mandatory)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mandatory field.';
                }
            }
        }
    }
}
