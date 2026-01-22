page 51279 "Posted Food Stocks/Date"
{
    Caption = 'Food Stocks By Date';
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Item,History,Special Prices & Discounts,Request Approval,Periodic Activities,Inventory,Attributes';
    SourceTable = Item;
    SourceTableView = WHERE("Item Category Code" = FILTER('FOOD'),
                            // "Posted Quantities"=FILTER(>0),
                            Inventory = FILTER(> 0));

    layout
    {
        area(content)
        {
            repeater(Item)
            {
                Caption = 'Item';
                Editable = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the item.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the item.';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if the item card represents a physical item (Inventory) or a service (Service).';
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = Basic, Suite;
                    HideValue = IsService;
                    ToolTip = 'Specifies how many units, such as pieces, boxes, or cans, of the item are in inventory.';
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the unit in which the item is held in inventory.';
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Visible = false;
                }
                field("Location Filter"; Rec."Location Filter")
                {
                }
                field("Date Filter"; Rec."Date Filter")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
        area(navigation)
        {
            group(Availability)
            {
                Caption = 'Availability';
                Image = Item;
                action("Items b&y Location")
                {
                    AccessByPermission = TableData 14 = R;
                    Caption = 'Items b&y Location';
                    Image = ItemAvailbyLoc;
                    ToolTip = 'Show a list of items grouped by location.';

                    trigger OnAction()
                    begin
                        PAGE.RUN(PAGE::"Items by Location", Rec);
                    end;
                }
                group("&Item Availability by")
                {
                    Caption = '&Item Availability by';
                    Image = ItemAvailability;
                    action("<Action5>")
                    {
                        Caption = 'Event';
                        Image = "Event";

                        trigger OnAction()
                        begin
                            //     ItemAvailFormsMgt.ShowItemAvailFromItem(Rec,ItemAvailFormsMgt.ByEvent);
                        end;
                    }
                    // action(Period)
                    // {
                    //     Caption = 'Period';
                    //     Image = Period;
                    //     RunObject = Page 157;
                    //     RunPageLink = No.=FIELD(No.),
                    //                   Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                    //                   Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),
                    //                   Location Filter=FIELD(Location Filter),
                    //                   Drop Shipment Filter=FIELD(Drop Shipment Filter),
                    //                   Variant Filter=FIELD(Variant Filter);
                    // }
                    // action(Variant)
                    // {
                    //     Caption = 'Variant';
                    //     Image = ItemVariant;
                    //     RunObject = Page 5414;
                    //     RunPageLink = No.=FIELD(No.),
                    //                   Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                    //                   Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),
                    //                   Location Filter=FIELD(Location Filter),
                    //                   Drop Shipment Filter=FIELD(Drop Shipment Filter),
                    //                   Variant Filter=FIELD(Variant Filter);
                    // }
                    // action(Location)
                    // {
                    //     Caption = 'Location';
                    //     Image = Warehouse;
                    //     RunObject = Page 492;
                    //     RunPageLink = No.=FIELD(No.),
                    //                   Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                    //                   Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),
                    //                   Location Filter=FIELD(Location Filter),
                    //                   Drop Shipment Filter=FIELD(Drop Shipment Filter),
                    //                   Variant Filter=FIELD(Variant Filter);
                    // }
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
    //    CRMCouplingManagement: Codeunit "5331";
    begin
        // SetSocialListeningFactboxVisibility;

        // CRMIsCoupledToRecord :=
        //   CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID) AND CRMIntegrationEnabled;

        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);

        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        //CurrPage.ItemAttributesFactBox.PAGE.LoadItemAttributesData("No.");
    end;

    trigger OnAfterGetRecord()
    begin
        SetSocialListeningFactboxVisibility;
        EnableControls;
    end;

    trigger OnOpenPage()
    var
    //  CRMIntegrationManagement: Codeunit "5330";
    begin
        // CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
        // IsFoundationEnabled := ApplicationAreaSetup.IsFoundationEnabled;
        // SetWorkflowManagementEnabledState;
    end;

    var
        //  TempFilterItemAttributesBuffer: Record "7506" temporary;
        //  ApplicationAreaSetup: Record "9178";
        //  CalculateStdCost: Codeunit "5812";
        //  ItemAvailFormsMgt: Codeunit "353";
        //  ApprovalsMgmt: Codeunit "1535";
        // SkilledResourceList: Page "6023";
        // IsFoundationEnabled: Boolean;
        //  [InDataSet]
        // SocialListeningSetupVisible: Boolean;
        [InDataSet]
        SocialListeningVisible: Boolean;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        OpenApprovalEntriesExist: Boolean;
        [InDataSet]
        IsService: Boolean;
        [InDataSet]
        InventoryItemEditable: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;

    procedure GetSelectionFilter(): Text
    var
        Item: Record "Item";
    // SelectionFilterManagement: Codeunit "46";
    begin
        ///   CurrPage.SETSELECTIONFILTER(Item);
        //  EXIT(SelectionFilterManagement.GetSelectionFilterForItem(Item));
    end;

    procedure SetSelection(var Item: Record "Item")
    begin
        CurrPage.SETSELECTIONFILTER(Item);
    end;

    local procedure SetSocialListeningFactboxVisibility()
    var
    //SocialListeningMgt: Codeunit "871";
    begin
        //    SocialListeningMgt.GetItemFactboxVisibility(Rec,SocialListeningSetupVisible,SocialListeningVisible);
    end;

    local procedure EnableControls()
    begin
        IsService := (Rec.Type = Rec.Type::Service);
        InventoryItemEditable := Rec.Type = Rec.Type::Inventory;
    end;

    local procedure SetWorkflowManagementEnabledState()
    var
    // WorkflowManagement: Codeunit "1501";
    // WorkflowEventHandling: Codeunit "1520";
    begin
        // EventFilter := WorkflowEventHandling.RunWorkflowOnSendItemForApprovalCode + '|' +
        //   WorkflowEventHandling.RunWorkflowOnItemChangedCode;

        // EnabledApprovalWorkflowsExist := WorkflowManagement.EnabledWorkflowExist(DATABASE::Item,EventFilter);
    end;
}

