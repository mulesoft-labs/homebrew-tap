# homebrew-tap

```
$ brew tap mulesoft-labs/tap
$ brew install aws-keycloak
```

## Modifying formulae
1. Create a Release (or Tag) for your source repo. Make sure it builds!
1. In the formula here, update the `url` and `sha256` with: `curl -L $url | shasum -a256`
1. Delete or comment our the `bottle do` block.
1. Make sure you don't have the formula installed already (eg. `brew remove aws-keycloak`)
1. Test with `brew install --verbose --debug HomebrewFormula/aws-keycloak.rb`, see that it builds as expected. (I had to try this half a dozen times before the build was clean, not sure why)
1. `git commit`, `git push`, `brew update`
1. Make sure it is not installed again (eg. `brew remove aws-keycloak`)
1. Install it from your tap and build the bottle: `brew install --build-bottle aws-keycloak`
1. Copy the output into your formula, but change the `root_url` to some place you can actually host the file, like a github release, eg. `https://github.com/mulesoft-labs/aws-keycloak/releases/download/v1.3.6/`
1. Upload the generated tar.gz file to that location, like by attaching it to the gh release. Make sure to change the filename to get rid of the `--`! It should be `$bin-$version.$os.bottle.tar.gz`.
1. Make sure it is not installed again.
1. Test the bottle with `brew install --force-bottle HomebrewFormula/aws-keycloak.rb`.
1. If it works, commit and push!
1. Test by `brew remove`ing it again, `brew update`, and `brew install aws-keycloak`. See that it uses the bottle rather than building.
