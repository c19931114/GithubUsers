//
//  UserData.swift
//  GithubUsers
//
//  Created by Crystal on 2021/10/5.
//

import Foundation

struct User: Codable {
    let id: Int
    let avatar_url: String
    let type: String
    let followers: Int
    let following: Int
    let name: String
    let location: String
    let email: String
}

/*
 
 {
   "login": "octocat",
   "id": 583231,
   "node_id": "MDQ6VXNlcjU4MzIzMQ==",
   "avatar_url": "https://avatars.githubusercontent.com/u/583231?v=4",
   "gravatar_id": "",
   "url": "https://api.github.com/users/octocat",
   "html_url": "https://github.com/octocat",
   "followers_url": "https://api.github.com/users/octocat/followers",
   "following_url": "https://api.github.com/users/octocat/following{/other_user}",
   "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
   "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
   "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
   "organizations_url": "https://api.github.com/users/octocat/orgs",
   "repos_url": "https://api.github.com/users/octocat/repos",
   "events_url": "https://api.github.com/users/octocat/events{/privacy}",
   "received_events_url": "https://api.github.com/users/octocat/received_events",
   "type": "User",
   "site_admin": false,
   "name": "The Octocat",
   "company": "@github",
   "blog": "https://github.blog",
   "location": "San Francisco",
   "email": null,
   "hireable": null,
   "bio": null,
   "twitter_username": null,
   "public_repos": 8,
   "public_gists": 8,
   "followers": 4042,
   "following": 9,
   "created_at": "2011-01-25T18:44:36Z",
   "updated_at": "2021-09-22T14:27:38Z"
 }
 
 [
   {
     "login": "octocat",
     "id": 1,
     "node_id": "MDQ6VXNlcjE=",
     "avatar_url": "https://github.com/images/error/octocat_happy.gif",
     "gravatar_id": "",
     "url": "https://api.github.com/users/octocat",
     "html_url": "https://github.com/octocat",
     "followers_url": "https://api.github.com/users/octocat/followers",
     "following_url": "https://api.github.com/users/octocat/following{/other_user}",
     "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
     "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
     "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
     "organizations_url": "https://api.github.com/users/octocat/orgs",
     "repos_url": "https://api.github.com/users/octocat/repos",
     "events_url": "https://api.github.com/users/octocat/events{/privacy}",
     "received_events_url": "https://api.github.com/users/octocat/received_events",
     "type": "User",
     "site_admin": false
   }
 ]
 
 */
