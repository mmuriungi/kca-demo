page 50553 "HRM-Appraisal Sup. Dept. Alloc"
{
    PageType = ListPart;
    SourceTable = "HRM-HOD Dept. Loading";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Appraisal Job Code"; Rec."Appraisal Job Code")
                {
                }
                field("Appraisal Target"; Rec."Appraisal Target")
                {
                }
                field("Appraisal Period Code"; Rec."Appraisal Period Code")
                {
                }
                field(HOD; Rec.HOD)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Appraisal Target Description"; Rec."Appraisal Target Description")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        //Units.RESET;
        //IF Units.GET(Programme,Stage,Unit) THEN
    end;

    var
        Units: Record "HRM-Appraisal Targets";
}

