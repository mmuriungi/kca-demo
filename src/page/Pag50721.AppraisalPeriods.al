page 50721 "Appraisal Periods"
{
    PageType = Worksheet;
    SourceTable = "Appraisal Periods";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Period; Rec.Period)
                {
                    // Editable = Fieldeditable;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    // Editable = Fieldeditable;
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
                {
                    // Editable = Fieldeditable;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Closed field.';
                }
            }
        }
    }

    actions
    {
    }
    trigger OnModifyRecord() myBoolean: Boolean;
    begin
        if Rec.Closed = true then Fieldeditable := false else Fieldeditable := true;
    end;

    var
        Fieldeditable: Boolean;
}

