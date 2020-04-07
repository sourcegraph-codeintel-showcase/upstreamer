package main

import (
	"fmt"

	"gopkg.in/yaml.v2"
)

type bkConfig struct {
	Env   map[string]string `yaml:"env"`
	Steps []bkStep          `yaml:"steps"`
}

type bkStep struct {
	Command string `yaml:"command"`
	Label   string `yaml:"label"`
}

type repoPair struct {
	owner string
	name  string
}

var repos = []repoPair{
	{"gohugoio", "hugo"},
	{"aws", "aws-sdk-go"},
	{"moby", "moby"},
	// {"prometheus", "prometheus"},
	// {"ReactiveX", "RxJS"},
	// {"sindresorhus", "got"},
	// {"angular", "angular"},
	// {"Microsoft", "TypeScript"},
	// {"lodash", "lodash"},
	// {"moment", "moment"},
}

func main() {
	steps := []bkStep{}
	for _, repo := range repos {
		steps = append(steps, bkStep{
			Command: fmt.Sprintf("./.buildkite/upstream.sh %s %s", repo.owner, repo.name),
			Label:   ":git:",
		})
	}

	config := bkConfig{
		Env:   map[string]string{"FORCE_COLOR": "1"},
		Steps: steps,
	}

	encoded, err := yaml.Marshal(config)
	if err != nil {
		panic(err.Error())
	}

	fmt.Printf("%s\n", encoded)
}
