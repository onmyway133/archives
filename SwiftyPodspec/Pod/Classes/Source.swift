//
//  Source.swift
//  Pods
//
//  Created by Khoa Pham on 1/16/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

public enum Source {
    case Git(SourceGit)
    case Subversion(SourceSubversion)
    case Mercurial(SourceMercurial)
    case HTTP(SourceHTTP)

    public struct SourceGit {
        let url: NSURL
        let tag: Version?
        let branch: String?
        let commit: String?

        public init(url: NSURL, tag: Version? = nil, branch: String? = nil, commit: String? = nil) {
            self.url = url
            self.tag = tag
            self.branch = branch
            self.commit = commit
        }
    }

    public struct SourceSubversion {
        let url: NSURL
        let tag: Version?

        public init(url: NSURL, tag: Version? = nil) {
            self.url = url
            self.tag = tag
        }
    }

    public struct SourceMercurial {
        let url: NSURL
        let revision: Version?

        public init(url: NSURL, revision: Version? = nil) {
            self.url = url
            self.revision = revision
        }
    }

    public struct SourceHTTP {
        let url: NSURL
        let hash: Hash?
        
        public init(url: NSURL, hash: Hash? = nil) {
            self.url = url
            self.hash = hash
        }
    }
}

public enum Hash {
    case Sha1(String)
    case Sha256(String)
}