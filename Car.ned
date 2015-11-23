
package org.mixim.examples.platoonBikes;

import org.mixim.base.modules.IBaseApplLayer;
import org.mixim.modules.application.platooning.protocols.BaseProtocol;
import org.mixim.modules.application.platooning.apps.BaseApp;
import org.mixim.modules.application.platooning.UnicastProtocol;
import org.mixim.modules.mobility.traci.TraCIMobility;
import org.mixim.modules.nic.Nic80211p;


module Car
{
    parameters:
        string appl_type;
        string protocol_type;

    gates:
        input radioIn; // gate for sendDirect
    submodules:

        appl: <appl_type> like BaseApp {
            parameters:
                @display("p=60,100");
        }

        prot: <protocol_type> like BaseProtocol {
            parameters:
                @display("p=60,200");
        }

        unicast: UnicastProtocol {
            parameters:
                @display("p=60,300");
        }

        nic: Nic80211p {
            parameters:
                @display("p=60,400");
        }

        mobility: TraCIMobility {
            parameters:
                @display("p=130,172;i=block/cogwheel");
        }
    connections allowunconnected:
        prot.upperLayerIn <-- appl.lowerLayerOut;
        prot.upperLayerOut --> appl.lowerLayerIn;
        unicast.upperControlIn <-- prot.lowerControlOut;
        unicast.upperControlOut --> prot.lowerControlIn;
        unicast.upperLayerIn <-- prot.lowerLayerOut;
        unicast.upperLayerOut --> prot.lowerLayerIn;
        nic.upperLayerIn <-- unicast.lowerLayerOut;
        nic.upperLayerOut --> unicast.lowerLayerIn;

        radioIn --> nic.radioIn;

}
