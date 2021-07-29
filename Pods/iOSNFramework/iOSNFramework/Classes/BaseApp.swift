//
//  BaseApp.swift
//  iOSNFramework
//
//  Created by noizar on 30/01/19.
//

import Foundation

public protocol ViewStateDelegate{
    func onSuccess(data:Any?,tag:String,message:String)
    func onFailure(data:Any?,tag:String,message:String)
    func onUpdate(data:Any?,tag:String,message:String)
    func onLoading(isLoading:Bool,tag:String,message:String)
}

open class NetworkState {
    fileprivate let viewDelegate:ViewStateDelegate
    fileprivate var tag = ""
    
    init(viewDelegate:ViewStateDelegate) {
        self.viewDelegate = viewDelegate
    }
    
    public func networkConfiguration(tag:String){
        self.tag = tag
    }
    
    public func onSucess (data:Any,message:String){
        viewDelegate.onSuccess(data: data, tag: self.tag, message: message)
    }
    
    public func onFailure(data:Any,message:String)  {
        viewDelegate.onFailure(data: data, tag: self.tag, message: message)
    }
    
    public func onUpdate(data:Any,message:String)  {
        viewDelegate.onUpdate(data: data, tag: self.tag, message: message)
    }
    
    public func onLoading(isLoading:Bool,message:String) {
        viewDelegate.onLoading(isLoading: isLoading, tag: self.tag, message: message)
    }
}

open class ModuleDelegate{
    open var network:NetworkState
    open var controller:UIViewController
    public init(viewStateDelegate:ViewStateDelegate,controller:UIViewController) {
        self.network = NetworkState(viewDelegate: viewStateDelegate)
        self.controller = controller
    }
}
