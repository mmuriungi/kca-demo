page 54225 "Soft Skills/ Behavior"
{
    PageType = List;
    //SourceTable = 58749;

    layout
    {
        area(content)
        {
            // repeater(General)
            // {
            //     field(Code;Code)
            //     {
            //     }
            //     field(Name;Name)
            //     {
            //     }
            // }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }

    var
        GatePass: Record "Service Gate Pass";
        Text001: Label 'Test Drive Gate Pass must first be forwarded for approval';
}

